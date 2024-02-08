//
//  TVShowModel.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import Foundation

class TVShowModel: ObservableObject {
    
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
    
    func fetchTrendingTvShows() {
        let request = URLSession.shared.dataTask(with: trendingUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let trending = try JSONDecoder().decode(TrendingsResult.self, from: data)
                DispatchQueue.main.async {
                    self?.trendingTvShows = trending
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
                }
            } catch {
                print("error top rated show: \(error)")
            }
        }
        request.resume()
    }
}
