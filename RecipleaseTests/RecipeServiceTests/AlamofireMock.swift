//
//  AlamofireMock.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 26/12/2021.
//

import Foundation
import Alamofire
@testable import Reciplease

// - MARK: MOCK RESPONSE

/// This structures defines two properties
/// used in MockRecipeSession class below
/// to pass needed parameters as a response.
struct MockResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

// - MARK: MOCK RECIPE SESSION

/// This class was created for testing purposes,
/// and conforms to AlamofireSession protocol,
/// allowing to fake a response when an instance
/// is initialized with given properties.
final class MockRecipeSession: AlamofireSession {
    private let mockResponse: MockResponse
    init(mockResponse: MockResponse) {
        self.mockResponse = mockResponse
    }
    
    /// This function conforms class to AlamofireSession protocol.
    /// - Parameters:
    ///     - url: A url value.
    ///     - completion: a closure returning  an AFDataResponse type.
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: mockResponse.response, data: mockResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        completion(dataResponse)
    }

}
