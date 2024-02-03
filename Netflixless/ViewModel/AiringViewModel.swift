//
//  AiringViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import Foundation
import Combine

class AiringViewModel: ObservableObject {
    @Published var airings:[OnAir] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            fatalError("API key not set. Please set the MOVIEDB_API_KEY environment variable.")
        }
        return apiKey
    }
    
    private var url: URL {
        let urlString = "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return url
    }
    
    func fetchAiringShows() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Airing.self, decoder: JSONDecoder())
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
            }, receiveValue: { [weak self] onAir in
                self?.airings = onAir
            })
            .store(in: &cancellables)
    }
    
}
