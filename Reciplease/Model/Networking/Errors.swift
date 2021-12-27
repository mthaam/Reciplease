//
//  Errors.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 16/12/21.
//

import Foundation
import Alamofire
import AlamofireImage

enum NetworkError: Error {
    case noData
    case noInputIngredients
    case unableToSetUrl
    case badResponse
    case unableToDecodeResponse
    case alamofireError(AFError)
}
