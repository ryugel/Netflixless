//
//  YoutubeViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import Foundation
import Combine

class YoutubeViewModel: ObservableObject {
    @Published  var trailers:[YouTubeItem] = []
    private var cancellables: Set<AnyCancellable> = []
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["YOUTUBE_API_KEY"] else {
            return "API key not set. Please set the Youtube_API_KEY environment variable."
        }
        return apiKey
    }
    
    func fetchTrailer(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=\(apiKey)") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: YouTubeData.self, decoder: JSONDecoder())
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("done downloading youtube")
                    break
                case .failure(let failure):
                    print("Failure: \(failure)")
                    
                }
            }, receiveValue: { [weak self] item in
                if let firstTrailer = item.first {
                                   self?.trailers = [firstTrailer]
                                   print("First trailer retrieved:", firstTrailer)
                               } else {
                                   print("No trailers found.")
                               }
            })
            .store(in: &cancellables)


    }
}
