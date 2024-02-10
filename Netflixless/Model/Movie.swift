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
    let results: [Movie]
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
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    let maximum, minimum: String
}


struct Movie: Media, Codable,Hashable,Identifiable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalLanguage: OriginalLanguage
    let originalTitle: String?
    let overview, posterPath: String
    let mediaType: MediaType?
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

enum OriginalLanguage: String, Codable,Hashable {
    case en = "en"
    case ja = "ja"
    case ko = "ko"
    case nl = "nl"
    case es = "es"
    case fr = "fr"
    case de = "de"
    case it = "it"
    case pt = "pt"
    case ru = "ru"
    case zh = "zh"
    case ar = "ar"
    case af = "af"
    case sq = "sq"
    case am = "am"
    case hy = "hy"
    case az = "az"
    case eu = "eu"
    case be = "be"
    case bn = "bn"
    case bs = "bs"
    case bg = "bg"
    case my = "my"
    case ca = "ca"
    case ceb = "ceb"
    case ny = "ny"
    case co = "co"
    case hr = "hr"
    case cs = "cs"
    case da = "da"
    case eo = "eo"
    case et = "et"
    case fo = "fo"
    case fil = "fil"
    case fi = "fi"
    case fy = "fy"
    case gl = "gl"
    case ka = "ka"
    case el = "el"
    case gu = "gu"
    case ht = "ht"
    case ha = "ha"
    case haw = "haw"
    case he = "he"
    case hi = "hi"
    case hmn = "hmn"
    case hu = "hu"
    case ig = "ig"
    case id = "id"
    case ga = "ga"
    case jw = "jw"
    case kn = "kn"
    case kk = "kk"
    case km = "km"
    case rw = "rw"
    case ky = "ky"
    case ku = "ku"
    case lo = "lo"
    case la = "la"
    case lv = "lv"
    case lt = "lt"
    case lb = "lb"
    case mk = "mk"
    case mg = "mg"
    case ms = "ms"
    case ml = "ml"
    case mt = "mt"
    case mi = "mi"
    case mr = "mr"
    case mn = "mn"
    case ne = "ne"
    case no = "no"
    case or = "or"
    case ps = "ps"
    case fa = "fa"
    case pl = "pl"
    case pa = "pa"
    case ro = "ro"
    case sm = "sm"
    case gd = "gd"
    case sr = "sr"
    case st = "st"
    case sn = "sn"
    case sd = "sd"
    case si = "si"
    case sk = "sk"
    case sl = "sl"
    case so = "so"
    case su = "su"
    case sw = "sw"
    case sv = "sv"
    case tg = "tg"
    case ta = "ta"
    case te = "te"
    case th = "th"
    case tr = "tr"
    case uk = "uk"
    case ur = "ur"
    case uz = "uz"
    case vi = "vi"
    case cy = "cy"
    case xh = "xh"
    case yi = "yi"
    case yo = "yo"
    case zu = "zu"
    
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
    let logoPath, name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}


struct ProductionCountry: Codable,Hashable {
    let iso3166_1, name: String

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
