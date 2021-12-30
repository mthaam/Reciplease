//
//  FavouriteViewController.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 9/12/21.
//

import UIKit
import CoreData

// - MARK: CLASS

class FavouriteViewController: UIViewController {
    
    // - MARK: PROPERTIES
    
    let coreDataManagement = FavouritesCoreDataManager.sharedFavoritesCoreDataManager
    var recipesToDisplay: [Recipe] = []
    var recipeToPrepareForSegue: Recipe!
    
    // - MARK: OUTLETS
    
    @IBOutlet weak var favsRecipeTableView: UITableView!
    @IBOutlet weak var nothingToShowLabel: UILabel!
    
}

// - MARK: FUNCTIONS OVERRIDES

extension FavouriteViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favsRecipeTableView.dataSource = self
        favsRecipeTableView.delegate = self
        favsRecipeTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveRecipes()
        favsRecipeTableView.reloadData()
        hideTableViewIfNoFavorites()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavouriteRecipesViewController" {
            let destinationVC = segue.destination as! FavouriteRecipesViewController
            destinationVC.recipe = recipeToPrepareForSegue
        }
    }
    
}

// - MARK: FUNCTIONS

extension FavouriteViewController {

    /// This function hides table view if
    /// there are no recipes saved in core data.
    private func hideTableViewIfNoFavorites() {
        nothingToShowLabel.text = "Nothing to show yet. \nFind recipes and touch favorite button \nin recipe detail top right corner."
        if recipesToDisplay.count == 0 {
            favsRecipeTableView.isHidden = true
        } else {
            favsRecipeTableView.isHidden = false
        }
    }
    
    /// This function fetches recipes entities stored
    /// in core data.
    private func retrieveRecipes() {
        recipesToDisplay.removeAll()
        
        for recipe in coreDataManagement.all {
            if let label = recipe.label, let image = recipe.image, let url = recipe.url, let ingredients = recipe.ingredientLines {
                let ingredientsAsArray = ingredients.split(separator: "=").map { "\($0)" }
                let recipeToAppend = Recipe(label: label, image: image, url: url, ingredientLines: ingredientsAsArray, totalTime: recipe.totalTime, yield: recipe.yield)
                recipesToDisplay.append(recipeToAppend)
            }
        }
    }
    
}

// - MARK: TABLE VIEW DATA SOURCE PROTOCOL FUNCTIONS

extension FavouriteViewController: UITableViewDataSource {
    
    /// This function returns an Int value,
    /// defining the number of sections within the
    /// table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// This function returns an Int value,
    /// defining the number of rows in section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesToDisplay.count
    }
    
    /// This function returns a UITableVIewCell,
    /// containing an ingredient in list variable.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCellTableViewCell else {
            return UITableViewCell()
        }
        let recipe = recipesToDisplay[indexPath.row]
        let hit = Hit(recipe: recipe)

        cell.xibRecipeView.recipe = hit
        
        return cell
    }
}

// - MARK: TABLE VIEW DELEGATE FUNCTION

extension FavouriteViewController: UITableViewDelegate {
    
    /// This function puts the recipe object corresponding
    /// to selected row into var recipeToPrepareForSegue,
    /// and then performs segue to next VC.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeToPrepareForSegue = recipesToDisplay[indexPath.row]
        performSegue(withIdentifier: "segueToFavouriteRecipesViewController", sender: nil)
    }

    /// This function conforms view controller to
    /// UITableViewDelegate, allowing deleting
    /// cells from core data and table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = recipesToDisplay[indexPath.row]
            coreDataManagement.deleteRecipe(with: recipe) { success in
                if success {
                    recipesToDisplay.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    hideTableViewIfNoFavorites()
                } else {
                    presentAlert(withMessage: "Unable to delete this recipe from favorites.")
                }
            }
        }
    }
}

// - MARK: ALERTS

extension FavouriteViewController {
    
    /// This function displays an alert to user.
    /// - Parameter withMessage : A string value, which
    /// is the message displayed in case of an Alert.
    private func presentAlert(withMessage: String) {
        let alertViewController = UIAlertController(title: "Warning", message: withMessage, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
}
