//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 11/12/21.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var greyview: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var numberOfLIkesLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRoundCornersToLikeAndCookingViews()
    }

    private func makeRoundCornersToLikeAndCookingViews() {
        greyview.layer.cornerRadius = 10
        blackView.layer.cornerRadius = 10
    }

    func configure(with recipe: Hit) {
        recipeName.text = recipe.recipe.label
        ingredientsListLabel.text = recipe.recipe.ingredientLines.joined(separator: ", ")
        if let cookingTime = recipe.recipe.totalTime {
            cookingTimeLabel.text = "🕓 \(Int(cookingTime)) mn"
        } else {
            cookingTimeLabel.text = "🕓 unknown"
        }
        if let likes = recipe.recipe.yield {
            numberOfLIkesLabel.text = "🏆 \(likes)"
        } else {
            numberOfLIkesLabel.text = "👍 N/A"
        }
        guard let imageURL = recipe.recipe.image else {
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
        
    }
    
}
