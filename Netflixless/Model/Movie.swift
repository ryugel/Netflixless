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

// MARK: - Result
struct Movie: Media, Codable,Hashable,Identifiable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String?
    let originalLanguage: OriginalLanguage
    let originalTitle: String?
    let overview, posterPath: String
    let mediaType: MediaType?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?

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
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
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
