//
//  RecipeService.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 15/12/21.
//

import Foundation
import Alamofire
import AlamofireImage

/// This class serves to call Api and
/// fetch recipes.
/// - Note that var session conforms
/// to AlamofireSession protocol for testing purposes.
/// When used in production, session is initialized by
/// default with RecipeSession, which uses the
/// real Alamofire.
final class RecipeService {
    
    static let shared = RecipeService()
    var session: AlamofireSession

    init(session: AlamofireSession = RecipeSession()) {
        self.session = session
    }

    /// This function fetches recipes based on given ingredients.
    /// - Parameter ingredients : A string value
    /// reprensenting ingredients all serated by a comma.
    /// - Parameter completion : a closure returning
    /// a result type depending on success/failure
    func fetchRecipes(with ingredients: String, completion: @escaping (Result<RecipeData, NetworkError>) -> Void) {
        
        guard let url = getRecipeURL(query: ingredients) else {
            completion(.failure(.unableToSetUrl))
            return
        }
        
        session.request(with: url) { response in
            DispatchQueue.main.async {
                guard let data = response.data, response.error == nil else {
                    completion(.failure(.noData))
                    return
                }
                guard let response = response.response, response.statusCode == 200 else {
                    completion(.failure(.badResponse))
                    return
                }
                do {
                    completion(.success(try JSONDecoder().decode(RecipeData.self, from: data)))
                } catch {
                    completion(.failure(.unableToDecodeResponse))
                }
            }
        }

    }
    
    /// This functions return an optionnal URL
    /// - Parameter query : A string value
    /// reprensenting ingredients all serated by a comma.
    func getRecipeURL(query: String) -> URL? {
        var urlComponents = URLComponents()
        if query != "" {
            urlComponents.scheme = "https"
            urlComponents.host = "api.edamam.com"
            urlComponents.path = "/api/recipes/v2"
            urlComponents.queryItems = [
                URLQueryItem(name: "app_id", value: "64c8a528"),
                URLQueryItem(name: "app_key", value: "63842f43146f8483807ee9115dbfbc43"),
                URLQueryItem(name: "type", value: "public"),
                URLQueryItem(name: "q", value: query)
            ]
        } else {
            return nil
        }
        return urlComponents.url
    }

}
