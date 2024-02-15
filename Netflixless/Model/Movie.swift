//
//  Model.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import Foundation

// MARK: - Trendings
struct Trendings: Codable {
    let page: Int
    var results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct UpcomingMovies: Codable {
    let dates: Dates
    let page: Int
    var results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieCollection: Codable {
    let id: Int
    let name, overview, posterPath, backdropPath: String?
    let parts: [Movie]

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case parts
    }
}

struct Dates: Codable {
    let maximum, minimum: String
}


struct Movie: Media, Codable,Hashable,Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalLanguage: OriginalLanguage
    let originalTitle: String?
    let overview, posterPath: String
    var mediaType: MediaType?
    let genreIDS: [Int]?
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?
    
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let imdbID: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline: String?
    let credits: Credits?
     
    var hasCollection: Bool?
    
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
         case name
         case originalName = "original_name"
         case firstAirDate = "first_air_date"
         case originCountry = "origin_country"
         case belongsToCollection = "belongs_to_collection"
         case budget, genres, homepage, imdbID
         case productionCompanies = "production_companies"
         case productionCountries = "production_countries"
         case revenue, runtime
         case spokenLanguages = "spoken_languages"
         case status, tagline
         case credits
         case hasCollection = "true"
     }
     
     static func == (lhs: Movie, rhs: Movie) -> Bool {
             return lhs.id == rhs.id
                 && lhs.title == rhs.title
                 && lhs.originalLanguage == rhs.originalLanguage
                 && lhs.originalTitle == rhs.originalTitle
                 && lhs.overview == rhs.overview
                 && lhs.posterPath == rhs.posterPath
                 && lhs.mediaType == rhs.mediaType
                 && lhs.genreIDS == rhs.genreIDS
                 && lhs.popularity == rhs.popularity
                 && lhs.releaseDate == rhs.releaseDate
                 && lhs.video == rhs.video
                 && lhs.voteAverage == rhs.voteAverage
                 && lhs.voteCount == rhs.voteCount
                 && lhs.name == rhs.name
                 && lhs.originalName == rhs.originalName
                 && lhs.firstAirDate == rhs.firstAirDate
                 && lhs.originCountry == rhs.originCountry
                 && lhs.belongsToCollection == rhs.belongsToCollection
                 && lhs.budget == rhs.budget
                 && lhs.genres == rhs.genres
                 && lhs.homepage == rhs.homepage
                 && lhs.imdbID == rhs.imdbID
                 && lhs.productionCompanies == rhs.productionCompanies
                 && lhs.productionCountries == rhs.productionCountries
                 && lhs.revenue == rhs.revenue
                 && lhs.runtime == rhs.runtime
                 && lhs.spokenLanguages == rhs.spokenLanguages
                 && lhs.status == rhs.status
                 && lhs.tagline == rhs.tagline
         }
     func hash(into hasher: inout Hasher) {
         hasher.combine(id)
         hasher.combine(title)
         hasher.combine(originalLanguage)
         hasher.combine(originalTitle)
         hasher.combine(overview)
         hasher.combine(posterPath)
         hasher.combine(mediaType)
         hasher.combine(genreIDS)
         hasher.combine(popularity)
         hasher.combine(releaseDate)
         hasher.combine(video)
         hasher.combine(voteAverage)
         hasher.combine(voteCount)
         hasher.combine(name)
         hasher.combine(originalName)
         hasher.combine(firstAirDate)
         hasher.combine(originCountry)
         hasher.combine(belongsToCollection)
         hasher.combine(budget)
         hasher.combine(genres)
         hasher.combine(homepage)
         hasher.combine(imdbID)
         hasher.combine(productionCompanies)
         hasher.combine(productionCountries)
         hasher.combine(revenue)
         hasher.combine(runtime)
         hasher.combine(spokenLanguages)
         hasher.combine(status)
         hasher.combine(tagline)
         
     }
}

enum MediaType: String, Codable, Hashable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable, Hashable {
    case en, ja, ko, nl, es, fr, de, it, pt, ru, zh, ar, af, sq, am, hy, az, eu, be, bn, bs, bg, my, ca, ceb, ny, co, hr, cs, da, eo, et, fo, fil, fi, fy, gl, ka, el, gu, ht, ha, haw, he, hi, hmn, hu, ig, id, ga, jw, kn, kk, km, rw, ky, ku, lo, la, lv, lt, lb, mk, mg, ms, ml, mt, mi, mr, mn, ne, no, or, ps, fa, pl, pa, ro, sm, gd, sr, st, sn, sd, si, sk, sl, so, su, sw, sv, tg, ta, te, th,tl, tr, uk, ur, uz, vi, cy, xh, yi, yo, zu

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        if let language = OriginalLanguage(rawValue: rawValue) {
            self = language
        } else {
            self = .en
        }
    }
}
struct BelongsToCollection: Codable,Hashable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey,Hashable {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct ProductionCompany: Codable,Hashable {
    let id: Int
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}


struct ProductionCountry: Codable,Hashable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}


struct SpokenLanguage: Codable,Hashable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

struct Credits: Codable,Hashable {
    let cast: [Cast]?
    let crew: [Cast]?
}

struct Cast: Codable,Hashable, Identifiable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: Department?
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, job
    }
}

enum Department: String, Codable,Hashable{
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
    
}
