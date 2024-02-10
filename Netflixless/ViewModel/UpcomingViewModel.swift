//
//  UpcomingViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 10/02/2024.
//

import Foundation
import Combine

class UpcomingViewModel: ObservableObject {
    @Published var upcomings:[UpcomingShow] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            return "API key not set. Please set the MOVIEDB_API_KEY environment variable."
        }
        return apiKey
    }
    
    private var url: URL {
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1"
    
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return url
    }
    
    func fetchUpcomingShows() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Upcoming.self, decoder: JSONDecoder())
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
            }, receiveValue: { [weak self] upcoming in
                self?.upcomings = upcoming
            })
            .store(in: &cancellables)
    }
    

}
