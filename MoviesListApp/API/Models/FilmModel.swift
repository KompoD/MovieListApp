//
//  FilmModel.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 19/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import Foundation

// MARK: - FilmModel
struct FilmModel: Codable {
    let films: [Film]?
}

// MARK: - Film
struct Film: Codable {
    let id: Int?
    let localizedName, name: String?
    let year: Int?
    let rating: Double?
    let imageURL: String?
    let filmDescription: String?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case localizedName = "localized_name"
        case name, year, rating
        case imageURL = "image_url"
        case filmDescription = "description"
        case genres
    }
}
