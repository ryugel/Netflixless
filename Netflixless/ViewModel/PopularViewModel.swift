//
//  PopularViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import Foundation
import Combine

class PopularViewModel: ObservableObject {
    @Published var shows:[Show] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            fatalError("API key not set. Please set the MOVIEDB_API_KEY environment variable.")
        }
        return apiKey
    }
    
    private var url: URL {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=10543e6ec0309e58b715386d5aec25d5&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return url
    }
    
    func fetchShows() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Popular.self, decoder: JSONDecoder())
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
            }, receiveValue: { [weak self] show in
                self?.shows = show
            })
            .store(in: &cancellables)
    }
    
}
