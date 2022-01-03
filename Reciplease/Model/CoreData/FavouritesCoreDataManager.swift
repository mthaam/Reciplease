//
//  FavouritesCoreDataManagement.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 20/12/21.
//

import Foundation
import CoreData

/// This class is used to manage CRUD operations
/// in core data for RecipeObject objects.
/// - Note that the shared static let
/// is used for singleton pattern and uses
/// app's context.
/// - Note that an instance of this class can
/// be initialized with a different context for testing
/// purposes.
final class FavouritesCoreDataManager {
    
    static let sharedFavoritesCoreDataManager = FavouritesCoreDataManager(context: AppDelegate.viewContext)
    
    let recipleaseContext: NSManagedObjectContext
    
    public init(context:NSManagedObjectContext) {
        self.recipleaseContext = context
    }
    
    /// This var fetches all RecipeObjects entities store in
    /// core data.
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
    
    /// This function saves new RecipeObject in core data.
    /// - Parameter recipe : a Recipe object to save.
    /// - Parameter completion : a closure return
    /// a bool value.
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
    
    /// This function deletes a recipe stored in core data.
    /// - Parameter recipe : a Recipe object to save.
    /// - Parameter completion : a closure return
    /// a bool value.
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
    
    func checkIfRecipeIsAlreadyFavourite(with recipe: Recipe) -> Bool {
        var isFavourite = false
        for rec in all {
            if let url = rec.url, url == recipe.url {
                isFavourite = true
            }
        }
        return isFavourite
    }
}
