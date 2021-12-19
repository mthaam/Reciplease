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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        updateLabels()
    }

}

extension RecipeViewController {
    
    private func updateLabels() {
        guard recipe != nil else { return }
        recipeTitleLabel.text = recipe.label
        if let cookingTime = recipe.totalTime {
            cookingTimeLabel.text = "🕓 \(Int(cookingTime)) mn"
        } else {
            cookingTimeLabel.text = "🕓 unknown"
        }
        if let likes = recipe.yield {
            yieldLabel.text = "🏆 \(likes)"
        } else {
            yieldLabel.text = "👍 N/A"
        }
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
