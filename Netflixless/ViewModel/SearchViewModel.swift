//
//  SearchViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchedMovies:[TMDB] = []
    @Published var searchText = "" {
        didSet {
            searchTMDB()
        }
    }
    private var cancellables:Set<AnyCancellable> = []
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            return "API key not set. Please set the MOVIEDB_API_KEY environment variable."
        }
        return apiKey
    }
    
    func searchTMDB() {
        guard let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&api_key=\(apiKey)") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TMDBMResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("done searching")
                    break
                case .failure(let failure):
                    print("Failure: \(failure)")
                }
            }, receiveValue: { [weak self] movie in
                self?.searchedMovies = movie
            })
            .store(in: &cancellables)
    }
}
