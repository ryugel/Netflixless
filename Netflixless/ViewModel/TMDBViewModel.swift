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
                    print("finish")
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
            urlString =  "https://api.themoviedb.org/3/trending/all/day?api_key=\(apiKey)"
        case .topRated:
            urlString = "https://api.themoviedb.org/3/discover/tv?api_key=\(apiKey)&language=en-US&page=1&include_adult=false"
        case .popular:
            urlString =          "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
        case .upcoming:
            urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1"
        }
        return URL(string: urlString)
    }

}

