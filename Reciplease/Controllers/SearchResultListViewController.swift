//
//  SearchResultListViewController.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 10/12/2021.
//

import UIKit

class SearchResultListViewController: UIViewController {
    
    var recipeData: RecipeData?
    var recipeToPrepareForSegue: Recipe!
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        //
//        print(recipeData?.hits[0].recipe.label)
        //
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipeDetail" {
            let destinationVC = segue.destination as! RecipeViewController
            destinationVC.recipe = recipeToPrepareForSegue
        }
    }
}

extension SearchResultListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = recipeData?.hits.count else {
            //
            print("there is no data")
            return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
//        return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        guard let recipe = recipeData?.hits[indexPath.row] else { return cell }
        cell.configure(with: recipe)
        
        return cell
    }
}

extension SearchResultListViewController: UITableViewDelegate {
    
    /// This function puts the recipe object corresponding
    /// to selected row into recipeToPrepareForSegue,
    /// and then performs segue to next VC.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeToPrepareForSegue = recipeData?.hits[indexPath.row].recipe
        performSegue(withIdentifier: "segueToRecipeDetail", sender: nil)
    }
}
