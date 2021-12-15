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
}
