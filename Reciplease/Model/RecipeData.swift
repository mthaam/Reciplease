//
//  RecipeData.swift
//  Reciplease
//
//  Created by JEAN SEBASTIEN BRUNET on 16/12/21.
//

import Foundation


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

struct Links: Decodable {
    let next: Next
}

struct Next: Decodable {
    let href: String
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let image: String?
    let url: String
    let ingredientLines: [String]
    let totalTime: Double?
    let yield: Float?
}
