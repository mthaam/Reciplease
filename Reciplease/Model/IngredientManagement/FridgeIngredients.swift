//
//  FridgeIngredients.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 14/12/21.
//

import Foundation

/// This class manages ingredients shown in
/// the ingredient list of search view controller
final class FridgeIngredients {

    var list: [String] = []
    
    /// This function adds ingredients to
    /// list array.
    /// - Parameter items: A string
    /// value used to append list array
    func addIngredients(with items: String) {
        var elements: [String] {
            return items.split(separator: ",").map { "\($0)" }
        }
        for element in elements { list.append(element) }
        var count = 0
        for item in list {
            if item.first == " " {
                list[count].removeFirst()
            }
            count += 1
        }
    }

    /// This function removes a given ingredient to dictionnaries.
    /// - Parameter index : an Int value used to remove
    /// corresponding entry in dictionnary.
    func removeSpecificIngredients(for index: Int) {
        list.remove(at: index)
    }

    /// This function removes all
    /// ingredients in list array.
    func removeAllIngredients() {
        list.removeAll()
    }

    /// This function aggregates all ingredients
    /// and  returns a string which is the result
    /// of all strings stored in list array.
    func getAllIngredientsIntoOneString() -> String {
        var all = ""
        all = list.joined(separator: ",")
        return all
    }
    
}
