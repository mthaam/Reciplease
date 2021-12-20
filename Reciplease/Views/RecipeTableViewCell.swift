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
//        addGradient()
    }

    private func makeRoundCornersToLikeAndCookingViews() {
        greyview.layer.cornerRadius = 10
        blackView.layer.cornerRadius = 10
    }

    func configure(with recipe: Hit) {
        
        recipeName.text = recipe.recipe.label
        ingredientsListLabel.text = recipe.recipe.ingredientLines.joined(separator: ", ")
        if let cookingTime = recipe.recipe.totalTime, cookingTime != 0.0 {
            cookingTimeLabel.text = "🕓 \(Int(cookingTime)) mn"
        } else {
            cookingTimeLabel.text = "🕓 N/A"
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
        addGradient()
        recipeImage.af.setImage(withURL: url)
    }

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: frame.height)
        gradientLayer.type = .axial
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor,
                                UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        recipeImage.layer.addSublayer(gradientLayer)
    }
    
}
