//
//  AlamofireMock.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 26/12/2021.
//

import Foundation
import Alamofire
@testable import Reciplease

struct MockResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class MockRecipeSession: AlamofireSession {
    private let mockResponse: MockResponse
    init(mockResponse: MockResponse) {
        self.mockResponse = mockResponse
    }
    
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: mockResponse.response, data: mockResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        completion(dataResponse)
    }

}
