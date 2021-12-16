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

    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientsTableView.reloadData()
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
}

extension SearchViewController {
    
    /// This function fetch recipes,
    /// using Alamofire.
    private func fetchRecipes() {
        let ingredientsAsOneString = ingredients.getAllIngredientsIntoOneString()
        let url = "https://api.edamam.com/api/recipes/v2"
        var parameters: [String: String] = [:]
        parameters["app_key"] =  "63842f43146f8483807ee9115dbfbc43"
        parameters["type"] =  "public"
        parameters["app_id"] =  "64c8a528"
        parameters["q"] =  "\(ingredientsAsOneString)"
        parameters["imageSize"] =  "LARGE"
        parameters["imageSize"] =  "REGULAR"
        let request = AF.request(url, parameters: parameters)
            .validate()
        request.responseJSON { (data) in
            print(data)
        }
    
        
        
        
    }

    /// This function adds ingredients to
    /// list variable in model.
    private func addIngredients() {
        guard let text = textField.text else {
            sendAlert()
            return
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
}

extension SearchViewController {
    
    private func sendAlert() {
        
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
