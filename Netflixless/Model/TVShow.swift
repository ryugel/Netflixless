//
//  TVShow.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import Foundation

struct TrendingsResult: Codable {
    let page: Int
    let results: [TVShow]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct TVShow: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name: String
    let originalLanguage: OriginalLanguage
    let originalName, overview, posterPath: String
    let mediaType: MediaType?
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String?
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [OriginCountry]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}


enum OriginCountry: String, Codable {
    case gb = "GB"
    case jp = "JP"
    case kr = "KR"
    case us = "US"
}

