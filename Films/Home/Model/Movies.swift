//
//  Movies.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 10/11/2020.
//

import Foundation

struct Movies: Codable {
    let listOfMovies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {
    
    let title: String
    let popularity: Double
    let movieID: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let sinposis: String
    let releaseDate: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case movieID = "id"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case sinposis = "overview"
        case releaseDate = "release_date"
        case image = "poster_path"
    }
}
