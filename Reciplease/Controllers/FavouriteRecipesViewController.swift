//
//  FavouriteRecipesViewController.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 10/12/2021.
//

import UIKit

class FavouriteRecipesViewController: UIViewController {

    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
    }
    
}

extension FavouriteRecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientCell", for: indexPath)
        return cell
    }
}
