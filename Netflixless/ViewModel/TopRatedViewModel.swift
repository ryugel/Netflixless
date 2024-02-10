//
//  PopularViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 02/02/2024.
//

import Foundation
import Combine

class TopRatedViewModel: ObservableObject {
    @Published var topRated:[Result] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            return "API key not set. Please set the MOVIEDB_API_KEY environment variable."
        }
        return apiKey
    }
    
    private var url: URL {
        let urlString = "https://api.themoviedb.org/3/discover/tv?api_key=\(apiKey)&language=en-US&page=1&include_adult=false"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return url
    }
    
    func fetchShows() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TopRated.self, decoder: JSONDecoder())
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
            }, receiveValue: { [weak self] topRated in
                self?.topRated = topRated
            })
            .store(in: &cancellables)
    }
    
}

