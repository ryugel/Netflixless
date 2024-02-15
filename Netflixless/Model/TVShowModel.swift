//
//  TVShowModel.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import Foundation

class TVShowModel: ObservableObject {
    @Published var tvShow: TVShow = TVShow(
        title: "Untitled Show",
        name: "Unnamed Show",
        adult: false,
        backdropPath: "/defaultBackdropPath.jpg",
        id: 1,
        originalLanguage: .en,
        originalName: "Untitled Original Name",
        overview: "No overview available.",
        posterPath: "/defaultPosterPath.jpg",
        mediaType: .tv,
        genreIDS: [0],
        popularity: 0.0,
        firstAirDate: "1970-01-01",
        voteAverage: 0.0,
        voteCount: 0,
        originCountry: [.US],
        runtime: 30,
        created_by: [CreatedBy(id: 1, credit_id: "defaultCreditID", name: "Default Creator", gender: 0, profile_path: "/defaultProfilePath.jpg")],
        episode_run_time: [30],
        genres: [Genre(id: 0, name: "Undefined Genre")],
        homepage: "https://example.com",
        in_production: true,
        languages: ["en"],
        last_air_date: "1970-01-01",
        last_episode_to_air: Episode(
            id: 1,
            name: "Default Episode",
            overview: "No overview available.",
            vote_average: 0.0,
            vote_count: 0,
            air_date: "1970-01-01",
            episode_number: 1,
            episode_type: "Undefined",
            production_code: "",
            runtime: 30,
            season_number: 1,
            show_id: 1,
            still_path: "/defaultEpisodeStillPath.jpg"
        ),
        next_episode_to_air: nil,
        networks: [Network(id: 1, logo_path: "/defaultLogoPath.jpg", name: "Default Network", origin_country: "US")],
        number_of_episodes: 1,
        number_of_seasons: 1,
        seasons: [Season(air_date: "1970-01-01", episode_count: 1, id: 1, name: "Default Season", overview: "No overview available.", poster_path: "/defaultSeasonPosterPath.jpg", season_number: 1, vote_average: 0.0)],
        spoken_languages: [SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")],
        status: "Unknown",
        tagline: "No tagline available.",
        type: "Unknown",
        vote_count: 0
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
        let urlString = "https://api.themoviedb.org/3/tv/\(tvId)?api_key=\(apiKey)"
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
