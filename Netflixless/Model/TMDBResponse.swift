//
//  TMDBMovie.swift
//  Netflixless
//
//  Created by Augustin Diabira on 10/02/2024.
//

import Foundation

struct TMDBMResponse: Codable {
    let page: Int
    let results: [TMDB]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TMDB: Codable, Hashable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originCountry: [String]?
    let originalLanguage: OriginalLanguage?
    let originalName, overview: String?
    let popularity: Double
    let posterPath: String?
    let firstAirDate: String?
    let name: String?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/original"
    }
}

enum OriginalLanguage: String, Codable {
    case ca = "ca"
    case en = "en"
    case ja = "ja"
    case ko = "ko"
    case nl = "nl"
    case fr = "fr"
    case de = "de"
    case af = "af"
    case es = "es"
    case pt = "pt"
    case zh = "zh"
    case cs = "cs"
    case hi = "hi"
}
