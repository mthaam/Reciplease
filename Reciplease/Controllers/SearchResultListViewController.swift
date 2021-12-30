//
//  SearchResultListViewController.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 10/12/2021.
//

import UIKit

// - MARK: CLASS

class SearchResultListViewController: UIViewController {
    
    // - MARK: VARS
    var recipeData: RecipeData?
    var recipeToPrepareForSegue: Recipe!
    var recipeImageToPrepareForSegue: UIImage?
    
    // - MARK: OUTLETS
    @IBOutlet weak var recipeTableView: UITableView!

}

// - MARK: FUNCTIONS OVERRIDES

extension SearchResultListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipeDetail" {
            let destinationVC = segue.destination as! RecipeViewController
            destinationVC.recipe = recipeToPrepareForSegue
        }
    }
    
}

// - MARK: TABLE VIEW DATA SOURCE PROTOCOL FUNCTIONS

extension SearchResultListViewController: UITableViewDataSource {
    
    /// This function returns an Int value,
    /// defining the number of sections within the
    /// table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// This function returns an Int value,
    /// defining the number of rows in section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = recipeData?.hits.count else {
            return 0 }
        return count
    }
    
    /// This function returns a UITableVIewCell,
    /// containing a summed up recipe.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCellTableViewCell else {
            return UITableViewCell()
        }
        guard let recipe = recipeData?.hits[indexPath.row] else { return cell }

        cell.xibRecipeView.recipe = recipe
        
        return cell
    }
}

// - MARK: TABLE VIEW DELEGATE FUNCTION

extension SearchResultListViewController: UITableViewDelegate {
    
    /// This function puts the recipe object corresponding
    /// to selected row into var recipeToPrepareForSegue,
    /// and then performs segue to next VC.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeToPrepareForSegue = recipeData?.hits[indexPath.row].recipe
        performSegue(withIdentifier: "segueToRecipeDetail", sender: nil)
    }
}
