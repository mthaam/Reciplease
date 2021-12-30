//
//  AlamofireService.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 26/12/2021.
//

import Foundation
import Alamofire

/// This protocol defines a single
/// method to call real Alamofire when
/// used in production, and a fake AF response when
/// used for testing purpose.
protocol AlamofireSession {
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void)
}

/// This class defines a single
/// method, which uses Alamofire for networking.
/// - Parameter url : a URL type used by Alamofire
/// - Parameter completion : a closure which returns
/// A AFDataResponse type.
final class RecipeSession: AlamofireSession {
    
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { responseData in
            completion(responseData)
        }
    }

}
