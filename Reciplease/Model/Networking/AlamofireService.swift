//
//  AlamofireService.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 26/12/2021.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void)
}

final class RecipeSession: AlamofireSession {
    
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { responseData in
            completion(responseData)
        }
    }

}
