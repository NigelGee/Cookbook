//
//  Recipe.swift
//  Test
//
//  Created by Nigel Gee on 13/05/2022.
//

import Foundation

struct Recipe: Codable, Identifiable {
    struct Ingredient: Codable {
        let name: String
        let quantity: Int
        let measurement: String
    }

    struct Method: Codable {
        let step: Int
        let text: String
    }

    let id: UUID
    let name: String
    let creator: String
    let dateCreated: Date
    let serves: Int
    let ingredients: [Ingredient]
    let method: [Method]
    let imageURL: URL
}
