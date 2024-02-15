//
//  TMDBViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 10/02/2024.
//

import Foundation
import Combine

class TMDBViewModel: ObservableObject {
    @Published var trendings:[TMDB] = []
    @Published var topRated:[TMDB] = []
    @Published var popular:[TMDB] = []
    @Published var upcoming:[TMDB] = []
    @Published var airing:[TMDB] = []
    private var cancellables:Set<AnyCancellable> = []
    
  
    
    func fetchTMDBData(tmdbUrl: TMDBURL) {
        
        guard let url = tmdbUrl.url else {
                  print("Invalid URL for : \(tmdbUrl)")
                  return
              }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TMDBMResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] tmdb in
                switch tmdbUrl {
                case .trending:
                    self?.trendings = tmdb
                case .topRated:
                    self?.topRated = tmdb
                case .popular:
                    self?.popular = tmdb
                case .upcoming:
                    self?.upcoming = tmdb
                case .airing:
                    self?.airing = tmdb
                }
            })
            .store(in: &cancellables)
    }
   
}
enum TMDBURL {
    case trending
    case topRated
    case popular
    case upcoming
    case airing
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            return "API key not set. Please set the MOVIEDB_API_KEY environment variable."
        }
        return apiKey
    }
    
    var url: URL? {
        var urlString:String
        switch self {
        case .trending:
            urlString =  "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)"
        case .topRated:
            urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)"
        case .popular:
            urlString =          "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        case .upcoming:
            urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)"
        case .airing:
             urlString = "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(apiKey)"
        }
        return URL(string: urlString)
    }

}

