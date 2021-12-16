//
//  FridgeIngredients.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 14/12/21.
//

import Foundation

class FridgeIngredients {

    var list: [String] = []
    var listWithComma: [String] = []
    
    func addIngredients(with items: String) {
        var elements: [String] {
            return items.split(separator: ",").map { "\($0)" }
        }
        var elementsWithComma: [String] {
            return items.split(separator: " ").map { "\($0)" }
        }
        for element in elements { list.append(element) }
        var count = 0
        for item in list {
            if item.first == " " {
                list[count].removeFirst()
            }
            count += 1
        }
        for elementWithComma in elementsWithComma { listWithComma.append(elementWithComma) }
    }

    /// This function removes a given ingredient to dictionnaries.
    /// - Parameter index : an Int value used to remove
    /// corresponding entry in dictionnary.
    func removeSpecificIngredients(for index: Int) {
        list.remove(at: index)
        listWithComma.remove(at: index)
    }

    func removeAllIngredients() {
        list.removeAll()
        listWithComma.removeAll()
    }

    func getAllIngredientsIntoOneString() -> String {
        var all = ""
        for ingredient in listWithComma {
            all.append(ingredient)
        }
        return all
    }
    
}
