//
//  Constants.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 09/11/2020.
//

import Foundation

struct Constants {
    static let apiKey = "?api_key=44ce905d7875e2e9702161996fa09a52"
    
    struct URL {
        static let main = "https://api.themoviedb.org/3/"
        static let images = "https://image.tmdb.org/t/p/w200"

    }
    
    struct EndPoints {
        static let urlListPopularMobies = "movie/popular"
        static let detailMovie = "movie/"
    }
}
