//
//  RecipeService.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 15/12/21.
//

import Foundation
import Alamofire
import AlamofireImage

class RecipeService {
//    private init() {}
    
    private let url = "https://api.edamam.com/api/recipes/v2"
    private var parameters: [String: String] = [:]
    private let app_key =  "63842f43146f8483807ee9115dbfbc43"
    private let app_id =  "64c8a528"
    
    static let shared = RecipeService()
    var session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func fetchRecipes(with ingredients: String, completion: @escaping (Result<RecipeData, NetworkError>) -> Void) {
        
        guard ingredients.isEmpty == false else {
            completion(.failure(.noInputIngredients))
            return
        }
        parameters["app_key"] =  app_key
        parameters["type"] =  "public"
        parameters["app_id"] =  app_id
        parameters["q"] =  "\(ingredients)"
        
        session.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: RecipeData.self) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.alamofireError(error)))
                }
            }
    }

}
