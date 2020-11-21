//
//  MovieDetail.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 21/11/2020.
//

import Foundation

struct MovieDetail: Codable {
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let homepage: String
    let voteAverage: Double
    
    enum CodinKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case homepage
        case voteAverage = "vote_average"
    }
    
}
