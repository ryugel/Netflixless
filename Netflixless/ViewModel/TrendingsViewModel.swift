//
//  TrendingsViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 31/01/2024.
//

import Foundation
import Combine

class TrendingsViewModel: ObservableObject {
    @Published var movies:[Movie] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            return "API key not set. Please set the MOVIEDB_API_KEY environment variable."
        }
        return apiKey
    }
    
    private var url: URL {
        let urlString = "https://api.themoviedb.org/3/trending/all/day?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return url
    }
    
    func fetchTrends() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Trendings.self, decoder: JSONDecoder())
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
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }
    
}
