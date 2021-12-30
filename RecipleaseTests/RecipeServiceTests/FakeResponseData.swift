//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by SEBASTIEN BRUNET on 26/12/2021.
//

import Foundation

// MARK: - CLASS

class FakeResponseData {
    
    // MARK: - Corrupted Json Data
        static var recipeBadData: Data? {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "EdamamBadJsonData", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    
    // MARK: - Correct Json Data
        static var recipeCorrectData: Data? {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "EdamamCorrectJsonData", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
        static let recipeIncorrectData = "error".data(using: .utf8)!
    
    // MARK: - Response
        static let responseOK = HTTPURLResponse(
            url: URL(string: "https://blob.com")!,
            statusCode: 200, httpVersion: nil, headerFields: [:])!

        static let responseKO = HTTPURLResponse(
            url: URL(string: "https://blob.com")!,
            statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
        class RecipeError: Error {}
        static let recipeError = RecipeError()
}
