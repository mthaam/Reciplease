//
//  FavouriteCoreDataManagerTestCase.swift
//  RecipleaseTests
//
//  Created by SEBASTIEN BRUNET on 24/12/2021.
//

import XCTest
@testable import Reciplease
import CoreData

// - MARK: CLASS

class FavouriteCoreDataManagerTestCase: XCTestCase {

    // - MARK: PROPERTIES
    
    var coreDataManager: FavouritesCoreDataManager!
    
    // - MARK: FUNCTIONS OVERRIDES
    
    override func setUp() {
        super.setUp()
        coreDataManager = FavouritesCoreDataManager(context: FakeTestingPersistentContainer.testContext)
    }

    // - MARK: TESTING FUNCTIONS
    
    func testGivenCoreDataIsEmpty_WhenSavingARecipe_AllShouldCount1AndUrlShouldMatch() {
        coreDataManager.saveRecipeObject(with: ExampleRecipeDataObjects.creamyScrambledEggs) { success in
            XCTAssertTrue(coreDataManager.all.count == 1)
            XCTAssertEqual(coreDataManager.all[0].label, "Creamy Scrambled Eggs with Caviar Recipe")
        }
    }

    func testGivenCoreDataContains2Recipes_WhenDeletingRecipe_AllShouldCount1AndUrlShouldMatch() {
        coreDataManager.saveRecipeObject(with: ExampleRecipeDataObjects.creamySweetSausage) { success in
            XCTAssertTrue(coreDataManager.all.count == 1)
        }
        coreDataManager.saveRecipeObject(with: ExampleRecipeDataObjects.creamyScrambledEggs) { success in
            XCTAssertTrue(coreDataManager.all.count == 2)
        }
        
        coreDataManager.deleteRecipe(with: ExampleRecipeDataObjects.creamyScrambledEggs) { success in
            XCTAssertTrue(coreDataManager.all.count == 1)
        }
    }
    
    func testGivenCoreDataIsEmpty_WhenSavingRecipeWithANilRecipe_CompletionShouldReturnFalse() {
        coreDataManager.saveRecipeObject(with: ExampleRecipeDataObjects.nilRecipe) { success in
            XCTAssertTrue(success == false)
        }
    }
    
}
