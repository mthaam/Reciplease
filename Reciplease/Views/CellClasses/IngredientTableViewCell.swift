//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 10/12/21.
//

import UIKit

/// This class manages an ingredient cell
/// in search view controller.
class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    /// This function makes round corners
    /// to cell
    private func setupCell() {
        coloredView.layer.cornerRadius = 10
    }

    /// This function sets cell's label to
    /// desired text.
    func configure(with ingredient: String) {
        ingredientLabel.text = ingredient
    }

}
