//
//  FavouriteRecipesViewController.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 10/12/2021.
//

import UIKit
import SafariServices

// - MARK: CLASS

class FavouriteRecipesViewController: UIViewController {

    // - MARK: PROPERTIES
    
    let coreDataManagement = FavouritesCoreDataManager.sharedFavoritesCoreDataManager
    var recipe: Recipe!
    
    // - MARK: OUTLETS
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var favouriteStarIcon: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // - MARK: FUNCTIONS OVERRIDES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        updateLabels()
        makeRoundCornersToLikeAndCookingViews()
        toggleActivityIndicator(shown: false)
    }
    
    // - MARK: @IBACTIONS
    
    @IBAction func unsaveRecipe(_ sender: Any) {
        removeOrSaveRecipe()
    }
    
    @IBAction func openRecipeWebPage(_ sender: Any) {
        showRecipeWebPage()
    }
}

// - MARK: CORE DATA RELATED FUNCTIONS

extension FavouriteRecipesViewController {

    /// This function calls another function
    /// to remove or save a recipe in core data
    /// based on star icon' color.
    private func removeOrSaveRecipe() {
        toggleActivityIndicator(shown: true)
        if favouriteStarIcon.tintColor == .lightGray {
            saveRecipeObject()
        } else {
            unsaveRecipeObject()
        }
    }

    /// This function calls core data management
    /// class to save the recipe currently displayed.
    private func saveRecipeObject() {
        coreDataManagement.saveRecipeObject(with: recipe) { success in
            toggleActivityIndicator(shown: false)
            if success {
                favouriteStarIcon.tintColor = .recipleaseGreen
            } else {
                presentAlert(withMessage: "Unable to add this recipe to favorites.")
            }
        }
    }
    
    /// This function removes the given recipe from
    /// core data, calling the deleteRecipe() method
    /// from core data management class.
    private func unsaveRecipeObject() {
        coreDataManagement.deleteRecipe(with: recipe) { success in
            toggleActivityIndicator(shown: false)
            if success {
                favouriteStarIcon.tintColor = .lightGray
            } else {
                presentAlert(withMessage: "Unable to delete this recipe from favorites.")
            }
        }
    }
    
}

// - MARK: DISPLAY UPDATES FUNCTIONS

extension FavouriteRecipesViewController {
    
    /// This function updates label if recipe's
    /// information is available.
    private func updateLabels() {
        guard recipe != nil else { return }
        recipeTitleLabel.text = recipe.label
        if let cookingTime = recipe.totalTime, cookingTime != 0.0 {
            cookingTimeLabel.text = "🕓 \(Int(cookingTime)) mn"
        } else {
            cookingTimeLabel.text = "🕓 N/A"
        }
        if let likes = recipe.yield {
            yieldLabel.text = "🏆 \(likes)"
        } else {
            yieldLabel.text = "👍 N/A"
        }
        updatePicture()
    }
    
    /// This function updates recipe's
    /// pictures and adds a gradient.
    private func updatePicture() {
        guard let imageURL = recipe.image else {
            let image = UIImage(imageLiteralResourceName: "default_hamburger")
            recipeImage.image = image
            return
        }
        guard let url = URL(string: imageURL) else {
            let image = UIImage(imageLiteralResourceName: "default_hamburger")
            recipeImage.image = image
            return
        }
        recipeImage.af.setImage(withURL: url)
        addGradient()
    }
    
    /// This function makes round corners to top left view.
    private func makeRoundCornersToLikeAndCookingViews() {
        greyView.layer.cornerRadius = 10
        blackView.layer.cornerRadius = 10
    }
    
    /// This function adds a grandient to picture.
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: recipeImage.bounds.height)
        gradientLayer.type = .axial
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor,
                                UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        recipeImage.layer.addSublayer(gradientLayer)
    }

    /// This function toggles activity indicator
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }
    
}

// - MARK: ALERTS FUNCTIONS AND SAFARI WEB PAGE FUNCTION

extension FavouriteRecipesViewController {
    
    /// This function displays an alert to user.
    /// - Parameter withMessage : A string value, which
    /// is the message displayed in case of an Alert.
    private func presentAlert(withMessage: String) {
        let alertViewController = UIAlertController(title: "Warning", message: withMessage, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }

    /// This function opens a Safari View Controller
    /// if the current recipe display has an url.
    private func showRecipeWebPage() {
        guard let recipeURL = URL(string: recipe.url) else {
            presentAlert(withMessage: "Unable to load recipe web page.")
            return
        }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let safariVC = SFSafariViewController(url: recipeURL, configuration: config)
        present(safariVC, animated: true)
    }
    
}

// - MARK: TABLE VIEW DATA SOURCE PROTOCOL FUNCTIONS

extension FavouriteRecipesViewController: UITableViewDataSource {
    
    /// This function returns an Int value,
    /// defining the number of sections within the
    /// table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// This function returns an Int value,
    /// defining the number of rows in section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredientLines.count
    }
    
    /// This function returns a UITableVIewCell,
    /// containing an ingredient in list variable.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientCell", for: indexPath) as? RecipeDetailTableViewCell else {
            return UITableViewCell()
        }
        let ingredient = recipe.ingredientLines[indexPath.row]
        
        cell.configure(with: ingredient)
        
        return cell
    }
    
}
