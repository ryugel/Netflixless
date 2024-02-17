//
//  TVShow.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import Foundation

struct TrendingsResult: Codable {
    let page: Int
    var results: [TVShow]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct TVShow: Media, Codable, Hashable, Identifiable {
    
    var title: String?
    var name: String?
    let adult: Bool
    var backdropPath: String?
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalName, overview, posterPath: String
    var mediaType: MediaType?
    let genreIDS: [Int]?
    let popularity: Double
    let firstAirDate: String?
    let voteAverage: Double
    let voteCount: Int?
    let originCountry: [OriginCountry]
    var releaseDate: String? {
        return firstAirDate
    }
    var runtime: Int?
    var created_by: [CreatedBy]?
    var episode_run_time: [Int]?
    var genres: [Genre]?
    var homepage: String?
    var in_production: Bool?
    var languages: [String]?
    var last_air_date: String?
    var last_episode_to_air: Episode?
    var next_episode_to_air: Episode?
    var networks: [Network]?
    var number_of_episodes: Int?
    var number_of_seasons: Int?
    var seasons: [Season]?
    var spoken_languages: [SpokenLanguage]?
    var status: String?
    var tagline: String?
    var type: String?
    var credits: Credits?
    
    enum CodingKeys: String, CodingKey {

        case title
        case name
        case adult = "adult"
        case backdropPath
        case id = "id"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview   =  "overview"
        case posterPath = "poster_path"
        case mediaType
        case genreIDS
        case popularity = "popularity"
        case firstAirDate
        case voteAverage = "vote_average"
        case voteCount
        case originCountry = "origin_country"
        case runtime
        case created_by
        case episode_run_time
        case genres
        case homepage
        case in_production
        case languages
        case last_air_date
        case last_episode_to_air
        case next_episode_to_air
        case networks
        case number_of_episodes
        case number_of_seasons
        case seasons
        case spoken_languages
        case status
        case tagline
        case type
        case credits
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        try container.encode(id, forKey: .id)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originalName, forKey: .originalName)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encode(genreIDS, forKey: .genreIDS)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(firstAirDate, forKey: .firstAirDate)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(originCountry, forKey: .originCountry)
    }
    
    init(id: Int, title: String?, name: String?, adult: Bool, backdropPath: String?, originalLanguage: OriginalLanguage, originalName: String, overview: String, posterPath: String, mediaType: MediaType?, genreIDS: [Int]?, popularity: Double, firstAirDate: String?, voteAverage: Double, voteCount: Int?, originCountry: [OriginCountry], runtime: Int?, created_by: [CreatedBy]?, episode_run_time: [Int]?, genres: [Genre]?, homepage: String?, in_production: Bool?, languages: [String]?, last_air_date: String?, last_episode_to_air: Episode?, next_episode_to_air: Episode?, networks: [Network]?, number_of_episodes: Int?, number_of_seasons: Int?, seasons: [Season]?, spoken_languages: [SpokenLanguage]?, status: String?, tagline: String?, type: String?, credits: Credits?) {
            self.id = id
            self.title = title
            self.name = name
            self.adult = adult
            self.backdropPath = backdropPath
            self.originalLanguage = originalLanguage
            self.originalName = originalName
            self.overview = overview
            self.posterPath = posterPath
            self.mediaType = mediaType
            self.genreIDS = genreIDS
            self.popularity = popularity
            self.firstAirDate = firstAirDate
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.originCountry = originCountry
            self.runtime = runtime
            self.created_by = created_by
            self.episode_run_time = episode_run_time
            self.genres = genres
            self.homepage = homepage
            self.in_production = in_production
            self.languages = languages
            self.last_air_date = last_air_date
            self.last_episode_to_air = last_episode_to_air
            self.next_episode_to_air = next_episode_to_air
            self.networks = networks
            self.number_of_episodes = number_of_episodes
            self.number_of_seasons = number_of_seasons
            self.seasons = seasons
            self.spoken_languages = spoken_languages
            self.status = status
            self.tagline = tagline
            self.type = type
            self.credits = credits
        }

    
}



enum OriginCountry: String, Codable, Hashable {
    case AD, AE, AF, AG, AI, AL, AM, AO, AQ, AR, AS, AT, AU, AW, AX, AZ, BA, BB, BD, BE, BF, BG, BH, BI, BJ, BL, BM, BN, BO, BQ, BR, BS, BT, BV, BW, BY, BZ, CA, CC, CD, CF, CG, CH, CI, CK, CL, CM, CN, CO, CR, CU, CV, CW, CX, CY, CZ, DE, DJ, DK, DM, DO, DZ, EC, EE, EG, EH, ER, ES, ET, FI, FJ, FK, FM, FO, FR, GA, GB, GD, GE, GF, GG, GH, GI, GL, GM, GN, GP, GQ, GR, GS, GT, GU, GW, GY, HK, HM, HN, HR, HT, HU, ID, IE, IL, IM, IN, IO, IQ, IR, IS, IT, JE, JM, JO, JP, KE, KG, KH, KI, KM, KN, KP, KR, KW, KY, KZ, LA, LB, LC, LI, LK, LR, LS, LT, LU, LV, LY, MA, MC, MD, ME, MF, MG, MH, MK, ML, MM, MN, MO, MP, MQ, MR, MS, MT, MU, MV, MW, MX, MY, MZ, NA, NC, NE, NF, NG, NI, NL, NO, NP, NR, NU, NZ, OM, PA, PE, PF, PG, PH, PK, PL, PM, PN, PR, PS, PT, PW, PY, QA, RE, RO, RS, RU, RW, SA, SB, SC, SD, SE, SG, SH, SI, SJ, SK, SL, SM, SN, SO, SR, SS, ST, SV, SX, SY, SZ, TC, TD, TF, TG, TH, TJ, TK, TL, TM, TN, TO, TR, TT, TV, TW, TZ, UA, UG, UM, US, UY, UZ, VA, VC, VE, VG, VI, VN, VU, WF, WS, YE, YT, ZA, ZM, ZW
}

struct CreatedBy: Codable, Hashable {
    let id: Int?
    let credit_id, name: String?
    let gender: Int?
    let profile_path: String?

    enum CodingKeys: String, CodingKey {
        case id, credit_id, name, gender, profile_path
    }
}

struct Episode: Codable, Hashable {
    let id: Int?
    let name: String?
    let overview: String?
    let vote_average: Double?
    let vote_count: Int?
    let air_date: String?
    let episode_number: Int?
    let episode_type: String?
    let production_code: String?
    let runtime: Int?
    let season_number: Int?
    let show_id: Int?
    let still_path: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview, vote_average, vote_count, air_date, episode_number, episode_type, production_code, runtime, season_number, show_id, still_path
    }
}

struct Network: Codable, Hashable {
    let id: Int?
    let logo_path: String?
    let name, origin_country: String?

    enum CodingKeys: String, CodingKey {
        case id, logo_path, name, origin_country
    }
}

struct Season: Codable, Hashable,Identifiable {
    let air_date: String?
    let episode_count, id: Int?
    let name, overview, poster_path: String?
    let season_number: Int?
    let vote_average: Double?

    enum CodingKeys: String, CodingKey {
        case air_date, episode_count, id, name, overview, poster_path, season_number, vote_average
    }
}
