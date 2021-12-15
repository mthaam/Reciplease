//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 10/12/21.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    private func setupCell() {
        coloredView.layer.cornerRadius = 10
    }

    func configure(with ingredient: String) {
        ingredientLabel.text = ingredient
    }

}
