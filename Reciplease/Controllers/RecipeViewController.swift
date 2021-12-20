//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 10/12/2021.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var recipe: Recipe!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var blackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        updateLabels()
        makeRoundCornersToLikeAndCookingViews()
    }

}

extension RecipeViewController {
    
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

    private func makeRoundCornersToLikeAndCookingViews() {
        greyView.layer.cornerRadius = 10
        blackView.layer.cornerRadius = 10
    }

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
}

extension RecipeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientCell", for: indexPath) as? RecipeDetailTableViewCell else {
            return UITableViewCell()
        }
        let ingredient = recipe.ingredientLines[indexPath.row]
        cell.configure(with: ingredient)
        
        return cell
    }
}
