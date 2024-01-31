//
//  Model.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import Foundation

struct Trendings: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable, Hashable, Identifiable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String?
    let originalLanguage, originalTitle, overview: String?
    let posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
   
    
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/original"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}
