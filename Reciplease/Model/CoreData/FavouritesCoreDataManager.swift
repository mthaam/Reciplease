//
//  FavouritesCoreDataManagement.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 20/12/21.
//

import Foundation
import CoreData

class FavouritesCoreDataManager {
    
    static let sharedFavoritesCoreDataManager = FavouritesCoreDataManager(context: AppDelegate.viewContext)
    
    let recipleaseContext: NSManagedObjectContext
    
    public init(context:NSManagedObjectContext) {
        self.recipleaseContext = context
    }
    
    var all: [RecipeObject] {
        let request: NSFetchRequest<RecipeObject> = RecipeObject.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "label", ascending: true)]
        var recipeObjects: [RecipeObject] = []
        if let recipes = try? recipleaseContext.fetch(request) {
            recipeObjects = recipes
        }
        return recipeObjects
    }
    
    func saveRecipeObject(with recipe: Recipe!, completion: (Bool) -> Void) {
        let recipeObject = RecipeObject(context: recipleaseContext)
        guard recipe != nil else { completion(false)
            return }
        recipeObject.label = recipe.label
        if let image = recipe.image {
            recipeObject.image = image
        }
        recipeObject.url = recipe.url
        if let totalTime = recipe.totalTime {
            recipeObject.totalTime = totalTime
        }
        if let yield = recipe.yield {
            recipeObject.yield = yield
        }
        recipeObject.ingredientLines = recipe.ingredientLines.joined(separator: " = ")
        
        try? recipleaseContext.save()
        completion(true)
    }
    
    func deleteRecipe(with recipeToDelete: Recipe!, completion: (Bool) -> Void) {
        let request: NSFetchRequest<RecipeObject> = RecipeObject.fetchRequest()
        
        if let recipes = try? recipleaseContext.fetch(request) {
            for recipe in recipes {
                if recipe.url == recipeToDelete.url {
                    recipleaseContext.delete(recipe)
                }
            }
        }
        
        try? recipleaseContext.save()
        completion(true)
        
    }
}
