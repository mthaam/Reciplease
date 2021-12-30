//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by SEBASTIEN BRUNET on 26/12/2021.
//

import XCTest
@testable import Reciplease

// - MARK: CLASS

class RecipeServiceTests: XCTestCase {

    // - MARK: TESTING FUNCTIONS
    
    func testGivenThereAreNoIngredientsToSearch_WhenFetchingRecipes_CompletionShouldReturnNoInputIngredientsError() {
        let mockSession = MockRecipeSession(mockResponse: MockResponse(response: nil, data: nil))
        let recipeSession = RecipeService(session: mockSession)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSession.fetchRecipes(with: "") { result in
            guard case .failure(let error) = result else {
                XCTFail("Nothing failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGivenAttemptingToFetchRecipes_WhenReceivingResponseAndThereIsNoData_CallbackShouldPostFailure() {
        let mockSession = MockRecipeSession(mockResponse: MockResponse(response: nil, data: nil))
        let recipeSession = RecipeService(session: mockSession)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSession.fetchRecipes(with: "cheese,cream") { result in
            guard case .failure(let error) = result else {
                XCTFail("Nothing failed in No Data test.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGivenAttemptingToFetchRecipes_WhenReceivingDataButBadResponse_CallbackShouldPostFailure() {
        let mockSession = MockRecipeSession(mockResponse: MockResponse(response: FakeResponseData.responseKO, data: FakeResponseData.recipeCorrectData))
        let recipeSession = RecipeService(session: mockSession)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSession.fetchRecipes(with: "cheese,cream") { result in
            guard case .failure(let error) = result else {
                XCTFail("Nothing failed in Bad Response Test.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGivenAttemptingToFetchRecipes_WhenReceivingCorrectDataWithNoErrorAndCorrectResponse_CompletionShouldPostSuccess() {
        let recipeLabelToEquate = "Lemon-Avocado Spaghetti With Shrimp From 'Pasta Modern'"
        let mockSession = MockRecipeSession(mockResponse: MockResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeCorrectData))
        let recipeSession = RecipeService(session: mockSession)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSession.fetchRecipes(with: "cheese,cream") { result in
            guard case .success(let data) = result else {
                XCTFail("Test with correct data failed.")
                return
            }
            XCTAssertTrue(data.hits[0].recipe.label == recipeLabelToEquate )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGivenAttemptingToFetchRecipes_WhenReceivingCorruptedDataWithNoErrorAndCorrectResponse_CallbackShouldPostFailure() {
        let mockSession = MockRecipeSession(mockResponse: MockResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeBadData))
        let recipeSession = RecipeService(session: mockSession)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSession.fetchRecipes(with: "cheese,cream") { result in
            guard case .failure(let error) = result else {
                XCTFail("Nothing failed in Corrupted Data Test.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

}
