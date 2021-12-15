//
//  FavouriteViewController.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 9/12/21.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var favsRecipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favsRecipeTableView.dataSource = self

    }

}

extension FavouriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        return cell
    }
}
