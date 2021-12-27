//
//  RecipeDetailTableViewCell.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 17/12/21.
//

import UIKit

class RecipeDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with ingredient: String) {
        ingredientLabel.text = ingredient
    }

}
