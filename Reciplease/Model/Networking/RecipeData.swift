//
//  RecipeData.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 16/12/21.
//

import Foundation

/// This structure defines data as decoded when receiving json,
/// from Edamam.
/// It conforms to Decodable protocol.
struct RecipeData: Decodable {
    let count: Int
    let links: Links?
    let hits: [Hit]
    
    enum CodingKeys: String, CodingKey {
        case count
        case links = "_links"
        case hits
    }
}

/// This structure conforms to Decodable
/// protocol and decodes the "Links" object
/// from json received from edamam's json.
struct Links: Decodable {
    let next: Next
}

/// This structure conforms to Decodable
/// protocol and decodes the "next " object
/// from json received from edamam's json.
struct Next: Decodable {
    let href: String
}

/// This structure conforms to Decodable
/// protocol and decodes the hit object
/// from json received from edamam's json.
struct Hit: Decodable {
    let recipe: Recipe
}

/// This structure defines recipes objects,
/// used both when decoding json from Alamofire,
/// and in core data when saving/fetching/deleting objects.
/// It conforms to Decodable protocol for
/// decoding json purposes.
struct Recipe: Decodable {
    var label: String
    var image: String?
    var url: String
    var ingredientLines: [String]
    var totalTime: Double?
    var yield: Float?
}
