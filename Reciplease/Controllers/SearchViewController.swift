//
//  SearchViewController.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 9/12/21.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var ingredientsList: [String] = []
    var ingredients = FridgeIngredients()
    var recipeData: RecipeData!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        textField.delegate = self
        toggleActivityIndicator(shown: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientsTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipesList" {
            let destinationVC = segue.destination as! SearchResultListViewController
            destinationVC.recipeData = recipeData
        }
      
    }

    @IBAction func search(_ sender: Any) {
        fetchRecipes()
    }
    
    @IBAction func addIngredientsToTableView(_ sender: Any) {
        addIngredients()
    }
    
    @IBAction func clearIngredientsFromTableView(_ sender: Any) {
        clearIngredients()
    }
    
    @IBAction func testSearch(_ sender: Any) {
        fetchRecipes()
    }
}

extension SearchViewController {
    
    /// This function fetch recipes,
    /// using Alamofire.
    private func fetchRecipes() {
        let ingredientsAsOneString = ingredients.getAllIngredientsIntoOneString()

        toggleActivityIndicator(shown: true)
        
        RecipeService.shared.fetchRecipes(with: ingredientsAsOneString) { result in
            switch result {
            case .success(let allRecipes):
                print("it worked!")
                self.recipeData = allRecipes
                self.toggleActivityIndicator(shown: false)
                //
//                print("!!!%%% \(self.recipeData?.hits[0].recipe.label) %%%!!!")
                self.performSegue(withIdentifier: "segueToRecipesList", sender: nil)
            case .failure(let error):
                self.toggleActivityIndicator(shown: false)
                self.presentAlert(withMessage: "Unable to find recipes with listed ingredients.")
                //
                print("something went wrong!")
                print(error.localizedDescription)
            }
        }
    }

    /// This function adds ingredients to
    /// list variable in model.
    private func addIngredients() {
        guard let text = textField.text else { return }
        if let count = textField.text?.count {
            if count == 0 {
                presentAlert(withMessage: "Please type at least one ingredient.")
            }
        }
        
        ingredients.addIngredients(with: text)
        textField.text = nil
        ingredientsTableView.reloadData()
    }

    /// This function clears ingredients from list
    /// variable in model.
    private func clearIngredients() {
        ingredients.removeAllIngredients()
        ingredientsTableView.reloadData()
    }

    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
}

extension SearchViewController {

    /// This function displays an alert to user.
    /// - Parameter withMessage : A string value, which
    /// is the message displayed in case of an Alert.
    private func presentAlert(withMessage: String) {
        let alertViewController = UIAlertController(title: "Warning", message: withMessage, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        let ingredient = ingredients.list[indexPath.row]
        cell.configure(with: ingredient)
        
        return cell
    }
}


extension SearchViewController: UITextFieldDelegate {
    
    /// This functions resigns textfield's first responder.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIngredients()
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.removeSpecificIngredients(for: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
