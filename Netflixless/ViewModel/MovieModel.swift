//
//  HomeViewModel.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 04/02/2024.
//

import Foundation

class MovieModel: ObservableObject {
    @Published var trendingMovies: [Movie] = []
    
    private var apiKey: String {
            guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
                fatalError("API key not set. Please set the MOVIEDB_API_KEY environment variable.")
            }
            return apiKey
        }
    
    private var trendingUrl: URL {
           let urlString = "https://api.themoviedb.org/3/trending/all/day?api_key=\(apiKey)"
           guard let url = URL(string: urlString) else {
               fatalError("Invalid URL")
           }
           return url
       }
    
    func fetchTrendingMovies() {
        //CALL API
        let request = URLSession.shared.dataTask(with: trendingUrl) {[weak self]
            data,_,error in
            //CHECK DATA
            guard let data = data, error == nil else {
                return
            }
            
            //CONVERT TO JSON
            do {
                let trending = try JSONDecoder().decode(Trendings.self, from: data)
                let trendingMovies = trending.results
                DispatchQueue.main.async {
                    self?.trendingMovies = trendingMovies
                }
                
            }catch {
                print(error)
            }
        }
        request.resume()
    }
    
}
