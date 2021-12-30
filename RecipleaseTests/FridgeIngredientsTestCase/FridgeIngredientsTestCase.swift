//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by JEAN SEBASTIEN BRUNET on 9/12/21.
//

import XCTest
@testable import Reciplease

// - MARK: CLASS

class FridgeIngredientsTests: XCTestCase {
    
    // - MARK: PROPERTIES
    
    var fridgeIngredients: FridgeIngredients!
    
    // - MARK: FUNCTIONS OVERRIDES
    
    override func setUp() {
        super.setUp()
        fridgeIngredients = FridgeIngredients()
    }

    // - MARK: TESTING FUNCTIONS
    
    func testGivenListArrayIsEmpty_WhenAdding3Ingredients_ThenListArrayCountShouldBe3() {
        fridgeIngredients.addIngredients(with: "tofu, cream, pasta")
        
        XCTAssertTrue(fridgeIngredients.list.count == 3)
    }

    func testGivenListArrayContainsIngredients_WhenRemove1Ingredients_ThenListArrayCountShouldBeDiminishedBy1() {
        fridgeIngredients.addIngredients(with: "tofu, cream, pasta")
        
        fridgeIngredients.removeSpecificIngredients(for: 2)
        
        XCTAssertTrue(fridgeIngredients.list.count == 2)
    }
    
    func testGivenListArrayContainsIngredients_WhenRemovingAllIngredients_ThenListArrayCountShouldBe0() {
        fridgeIngredients.addIngredients(with: "tofu, cream, pasta")
        
        fridgeIngredients.removeAllIngredients()
        
        XCTAssertTrue(fridgeIngredients.list.count == 0)
    }
    
    func testGivenListArrayContainsIngredients_WhenGettingAllIngredientsAsOneString_ThenAStringWithIngredientsSeparatedByCommasShouldBeReturned() {
        fridgeIngredients.addIngredients(with: "tofu, cream, pasta")
        
        let ingredientsAsOneString = fridgeIngredients.getAllIngredientsIntoOneString()
        
        XCTAssertEqual(ingredientsAsOneString, "tofu,cream,pasta")
    }
}
