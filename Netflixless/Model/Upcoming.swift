//
//  Upcoming.swift
//  Netflixless
//
//  Created by Augustin Diabira on 09/02/2024.
//

import Foundation

struct Upcoming: Codable {
    let page: Int
    let results: [UpcomingShow]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    static var MOCK_Popular: Popular = Bundle.main.decode(file: "Popular.json")
    static var popularShow = MOCK_Popular.results.first!
}

struct UpcomingShow: Codable, Hashable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double
    let posterPath: String?
    let firstAirDate, name: String?
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
