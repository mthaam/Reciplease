//
//  RecipeDetailTableViewCell.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 17/12/21.
//

import UIKit

/// This class manages the ingredients displayed in
/// a recipe detail view controller.
class RecipeDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// This function sets cell's label to
    /// desired text.
    func configure(with ingredient: String) {
        ingredientLabel.text = ingredient
    }

}
