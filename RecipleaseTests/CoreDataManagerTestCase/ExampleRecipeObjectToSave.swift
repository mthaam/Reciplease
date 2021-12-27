//
//  ExampleRecipeObjectToSave.swift
//  RecipleaseTests
//
//  Created by SEBASTIEN BRUNET on 24/12/2021.
//

import Foundation
@testable import Reciplease

/// This class defines 2 recipe objects examples
/// as if they were created after
///  network call and serialization.
class ExampleRecipeDataObjects {
    
    static let creamyScrambledEggs: Recipe = Recipe(
        label: "Creamy Scrambled Eggs with Caviar Recipe",
        image: "https://www.edamam.com/web-img/7db/7db759a7c47a83c181795200ce59037b.jpg",
        url: "http://www.seriouseats.com/recipes/2010/10/creamy-scrambled-eggs-with-caviar.html",
        ingredientLines: [
            "4 eggs",
            "1/4 teaspoon kosher salt",
            "1 tablespoon unsalted butter",
            "1 tablespoon heavy cream",
            "1-2 ounces caviar (see note)",
            "1/4 cup sour cream",
            "1/4 cup finely chopped red onions or shallots",
            "2-3 slices toast (see note)"
        ],
        totalTime: 10.0,
        yield: 4.0)
    
    static let creamySweetSausage: Recipe = Recipe (
        label: "Creamy Sweet Italian Chicken Sausage Gluten Free Pasta",
        image: "https://www.edamam.com/web-img/e0a/e0abae8251a2180bdeb16978af75b0c7.jpg",
        url: "https://food52.com/recipes/42485-creamy-sweet-italian-chicken-sausage-gluten-free-pasta",
        ingredientLines: [
            "8 ounces dry gluten free pasta (or whole grain pasta)",
            "1/4 cup reserved pasta water",
            "2 tablespoons olive or avocado oil",
            "1/4 red onion, chopped",
            "1 pound sweet italian chicken sausages",
            "4 garlic and herb laughing cow cheese wedges",
            "2 medium zucchini, chopped"
        ],
        totalTime: 10.0,
        yield: 6.0)
    
    static let nilRecipe: Recipe! = nil
    
}
