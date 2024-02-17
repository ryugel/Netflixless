//
//  TVShowModel.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import Foundation

class TVShowModel: ObservableObject {
    @Published var tvShow: TVShow = TVShow(
        id: 108978,
        title: "Reacher",
        name: "Reacher",
        adult: false,
        backdropPath: "/m5CggjJuFc08QCuKz54znHP6spJ.jpg",
        originalLanguage: .en,
        originalName: "Reacher",
        overview: "Jack Reacher, a veteran military police investigator, has just recently entered civilian life...",
        posterPath: "/jFuH0md41x5mB4qj5344mSmtHrO.jpg",
        mediaType: nil,
        genreIDS: [10759, 80, 18],
        popularity: 496.204,
        firstAirDate: "2022-02-03",
        voteAverage: 8.115,
        voteCount: 1397,
        originCountry: [.US],
        runtime: nil,
        created_by: [
            CreatedBy(id: 78417, credit_id: "5f54f833713ed40036eed3e7", name: "Nick Santora", gender: 2, profile_path: "/iipP9fTQhRuPJHFMhbpMCceBiiu.jpg")
        ],
        episode_run_time: [],
        genres: [
            Genre(id: 10759, name: "Action & Adventure"),
            Genre(id: 80, name: "Crime"),
            Genre(id: 18, name: "Drama")
        ],
        homepage: "https://www.amazon.com/dp/B09ML1ZF3D",
        in_production: true,
        languages: ["en"],
        last_air_date: "2024-01-18",
        last_episode_to_air: Episode(
            id: 4901216,
            name: "Fly Boy",
            overview: "Reacher and Neagley make a final desperate attempt to save O’Donnell and Dixon, stop A.M. and avenge their friends’ murder.",
            vote_average: 7.2,
            vote_count: 13,
            air_date: "2024-01-18",
            episode_number: 8,
            episode_type: "finale",
            production_code: "",
            runtime: 42,
            season_number: 2,
            show_id: 108978,
            still_path: "/7Jt8ghfYb2jx7hg1H5UbEUEH101.jpg"
        ),
        next_episode_to_air: nil,
        networks: [
            Network(id: 1024, logo_path: "/ifhbNuuVnlwYy5oXA5VIb2YR8AZ.png", name: "Prime Video", origin_country: "")
        ],
        number_of_episodes: 16,
        number_of_seasons: 2,
        seasons: [
            Season(
                air_date: "2022-02-03",
                episode_count: 8,
                id: 161571,
                name: "Season 1",
                overview: "Based on \"Killing Floor,\" when retired Military Police Officer Jack Reacher is arrested for a murder he did not commit, he finds himself in the middle of a deadly conspiracy full of dirty cops, shady businessmen and scheming politicians. With nothing but his wits, he must figure out what is happening in Margrave, Georgia.",
                poster_path: "/bQnnKBe3VsvXKMoNCaYmRzs1Dup.jpg",
                season_number: 1,
                vote_average: 7.4
            ),
            Season(
                air_date: "2023-12-14",
                episode_count: 8,
                id: 364732,
                name: "Season 2",
                overview: "Based on\"Bad Luck and Trouble,\" when members of Reacher's old military unit start turning up dead, Reacher has just one thing on his mind—revenge.",
                poster_path: "/oVw8KUQn1RSDd8KmknpvIc34JtY.jpg",
                season_number: 2,
                vote_average: 7.1
            )
        ],
        spoken_languages: [
            SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")
        ],
        status: "Returning Series",
        tagline: "Reacher's back.",
        type: "Scripted",
        credits: Credits(
            cast: [
                Cast(adult: false, gender: 2, id: 64295, knownForDepartment: Department(rawValue: "Acting"), name: "Alan Ritchson", originalName: "Alan Ritchson", popularity: 62.276, profilePath: "/wdmLUSPEC7dXuqnjTM4NgbjvTKk.jpg",castID: nil, character: "Jack Reacher", creditID: "5f54f95984f2490035f8e399", order: 0,job: nil),
                Cast(adult: false, gender: 1, id: 2123496, knownForDepartment: Department(rawValue: "Acting"), name: "Maria Sten", originalName: "Maria Sten", popularity: 24.896, profilePath: "/7QlPWbZRH2ORMmAHKAj0rq54t4A.jpg",castID: nil, character: "Frances Neagley", creditID: "61a969cb9a64350044e918ba", order: 2,job: nil),
                Cast(adult: false, gender: 1, id: 86268, knownForDepartment: Department(rawValue: "Acting"), name: "Serinda Swan", originalName: "Serinda Swan", popularity: 43.039, profilePath: "/mA4qtNZnn0A2oT1s4IIHseO8oiu.jpg",castID: nil, character: "Karla Dixon", creditID: "657c0646ec8a4300aa6e1522", order: 4,job: nil),
                Cast(adult: false, gender: 2, id: 65772, knownForDepartment: Department(rawValue: "Acting"), name: "Shaun Sipos", originalName: "Shaun Sipos", popularity: 11.548, profilePath: "/vXsKlHCCwwipQJoklvJisSVj6Fc.jpg",castID: nil, character: "David O'Donnell", creditID: "657c05cf8e2ba600c4f16f3f", order: 6,job: nil),
                Cast(adult: false, gender: 2, id: 1211873, knownForDepartment: Department(rawValue: "Acting"), name: "Ferdinand Kingsley", originalName: "Ferdinand Kingsley", popularity: 6.626, profilePath: "/arGWhGhfBl8CvNuUoKkUmfrDG0b.jpg",castID: nil, character: "A.M.", creditID: "657c401c7ecd280101d386c7", order: 8,job: nil),
                Cast(adult: false, gender: 2, id: 418, knownForDepartment: Department(rawValue: "Acting"), name: "Robert Patrick", originalName: "Robert Patrick", popularity: 27.562, profilePath: "/qRv2Es9rZoloullTbzss3I5j1Mp.jpg",castID: nil, character: "Shane Langston", creditID: "657c06af63e6fb011edd8e23", order: 9,job: nil)
            ],
            crew: [
                Cast(adult: false, gender: 2, id: 1703771, knownForDepartment: Department(rawValue: "Writing"), name: "Adam Higgs", originalName: "Adam Higgs", popularity: 3.839, profilePath: nil,castID: nil,character: nil, creditID: "657c468a7ecd28011ef2aed4",order: nil, job: "Executive Producer"),
                Cast(adult: false, gender: 0, id: 4431386, knownForDepartment: Department(rawValue: "Production"), name: "Matt Thunell", originalName: "Matt Thunell", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657c46d3564ec7011b21dccf",order: nil, job: "Executive Producer"),
                Cast(adult: false, gender: 1, id: 1611446, knownForDepartment: Department(rawValue: "Writing"), name: "Penny Cox", originalName: "Penny Cox", popularity: 1.757, profilePath: nil,castID: nil,character: nil, creditID: "657c470c8e2ba600e1fd41da",order: nil, job: "Producer"),
                Cast(adult: false, gender: 0, id: 1084756, knownForDepartment: Department(rawValue: "Art"), name: "Nazgol Goshtasbpour", originalName: "Nazgol Goshtasbpour", popularity: 1.955, profilePath: nil,castID: nil,character: nil, creditID: "657c472eea3949011b3cf89d",order: nil, job: "Production Design"),
                Cast(adult: false, gender: 0, id: 1525195, knownForDepartment: Department(rawValue: "Costume & Make-Up"), name: "Abram Waterhouse", originalName: "Abram Waterhouse", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657c473a564ec700acd67c95",order: nil, job: "Costume Design"),
                Cast(adult: false, gender: 0, id: 378260, knownForDepartment: Department(rawValue: "Production"), name: "Derek Rappaport", originalName: "Derek Rappaport", popularity: 3.791, profilePath: nil,castID: nil,character: nil, creditID: "657cae5addd52d011b69d105",order: nil, job: "Producer"),
                Cast(adult: false, gender: 0, id: 2414790, knownForDepartment: Department(rawValue: "Production"), name: "Lisa Kussner", originalName: "Lisa Kussner", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657cae937ecd28013b3f2efe",order: nil, job: "Consulting Producer"),
                Cast(adult: false, gender: 0, id: 4071653, knownForDepartment: Department(rawValue: "Directing"), name: "David Carruthers", originalName: "David Carruthers", popularity: 0.695, profilePath: nil,castID: nil,character: nil, creditID: "657caf0263e6fb0100c6dd39",order: nil, job: "Production Manager"),
                Cast(adult: false, gender: 0, id: 1772710, knownForDepartment: Department(rawValue: "Writing"), name: "Cait Duffy", originalName: "Cait Duffy", popularity: 1.715, profilePath: nil,castID: nil,character: nil, creditID: "657caf1b176a941730623b83",order: nil, job: "Story Editor"),
                Cast(adult: false, gender: 1, id: 4079766, knownForDepartment: Department(rawValue: "Writing"), name: "Lillian Wang", originalName: "Lillian Wang", popularity: 1.669, profilePath: nil,castID: nil,character: nil, creditID: "657cb13d176a941733d6c2ec",order: nil, job: "Staff Writer")
            ]
        )
    )
    @Published var trendingTvShows: TrendingsResult = TrendingsResult(page: 0, results: [], totalPages: 0, totalResults: 0)
    @Published var popularTvShows: TrendingsResult = TrendingsResult(page: 0, results: [], totalPages: 0, totalResults: 0)
    @Published var onTheAirTvShows: TrendingsResult = TrendingsResult(page: 0, results: [], totalPages: 0, totalResults: 0)
    @Published var topRatedTvShows: TrendingsResult = TrendingsResult(page: 0, results: [], totalPages: 0, totalResults: 0)
 
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            fatalError("API key not set. Please set the MOVIEDB_API_KEY environment variable.")
        }
        return apiKey
    }
    
    
    private var trendingUrl: URL {
        let urlString = "https://api.themoviedb.org/3/trending/tv/week?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    
    private var popularUrl: URL {
        let urlString = "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    private var currentlyPlayingUrl: URL {
        let urlString = "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    private var topRatedUrl: URL {
        let urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    func setMediaType(to type: String, for shows: inout [TVShow]) {
        for index in shows.indices {
            shows[index].mediaType = MediaType(rawValue: type)
        }
    }
    
    func setMediaTypeForTvShows() {
        setMediaType(to: "tv", for: &trendingTvShows.results)
        setMediaType(to: "tv", for: &popularTvShows.results)
        setMediaType(to: "tv", for: &onTheAirTvShows.results)
        setMediaType(to: "tv", for: &topRatedTvShows.results)
    }
    
    func fetchTrendingTvShows() {
        let request = URLSession.shared.dataTask(with: trendingUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let trending = try JSONDecoder().decode(TrendingsResult.self, from: data)
                DispatchQueue.main.async {
                    self?.trendingTvShows = trending
                    self?.setMediaTypeForTvShows()
                }
            } catch {
                print("error trending show: \(error)")
            }
        }
        request.resume()
    }

    func fetchPopularTvShows() {
        let request = URLSession.shared.dataTask(with: popularUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let popular = try JSONDecoder().decode(TrendingsResult.self, from: data)
                DispatchQueue.main.async {
                    self?.popularTvShows = popular
                    self?.setMediaTypeForTvShows()
                }
            } catch {
                print("error request popular show: \(error)")
            }
        }
        request.resume()
    }

    func fetchCurrentlyPlayingTvShows() {
        let request = URLSession.shared.dataTask(with: currentlyPlayingUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let currentlyPlaying = try JSONDecoder().decode(TrendingsResult.self, from: data)
                DispatchQueue.main.async {
                    self?.onTheAirTvShows = currentlyPlaying
                    self?.setMediaTypeForTvShows()
                }
            } catch {
                print("error request currently show: \(error)")
            }
        }
        request.resume()
    }

    
    func fetchTopRatedTvShows() {
        let request = URLSession.shared.dataTask(with: topRatedUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let topRated = try JSONDecoder().decode(TrendingsResult.self, from: data)
                DispatchQueue.main.async {
                    self?.topRatedTvShows = topRated
                    self?.setMediaTypeForTvShows()
                }
            } catch {
                print("error top rated show: \(error)")
            }
        }
        request.resume()
    }
    
    func createTvDetailsByIdUrl(tvId: Int) -> URL {
        let urlString = "https://api.themoviedb.org/3/tv/\(tvId)?api_key=\(apiKey)&append_to_response=credits"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    func fetchTvDetailsById(tvId: Int) {
        let request = URLSession.shared.dataTask(with: createTvDetailsByIdUrl(tvId: tvId)) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let tvShow = try JSONDecoder().decode(TVShow.self, from: data)
                DispatchQueue.main.async {
                    self?.tvShow = tvShow
                }
            } catch {
                print("error request movie \(error)")
            }
        }
        request.resume()
    }
}
