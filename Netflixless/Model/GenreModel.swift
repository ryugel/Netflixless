//
//  GenreModel.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 09/02/2024.
//

import Foundation

class GenreModel: ObservableObject {
 
    @Published var mediaGenres: [String] = []
    @Published var movieGenres: Genres = Genres(genres: [])
    @Published var tvGenres: Genres = Genres(genres: [])
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            fatalError("API key not set. Please set the MOVIEDB_API_KEY environment variable.")
        }
        return apiKey
    }
    
    
    private var movieGenresUrl: URL {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    private var TvGenresUrl: URL {
        let urlString = "https://api.themoviedb.org/3/genre/tv/list?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    
    func fetchMovieGenres() {
        let request = URLSession.shared.dataTask(with: movieGenresUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let genres = try JSONDecoder().decode(Genres.self, from: data)
                DispatchQueue.main.async {
                    self?.movieGenres = genres
                    print("Updated movie genres")
                }
            } catch {
                print("Error requesting movie genres:", error)
            }
        }

        request.resume()
    }
    
    func fetchTvGenres() {
        let request = URLSession.shared.dataTask(with: movieGenresUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let genres = try JSONDecoder().decode(Genres.self, from: data)
                DispatchQueue.main.async {
                    self?.tvGenres = genres
                    print("Updated tv genres")
                }
            } catch {
                print("error request genre movie")
            }
        }
        request.resume()
    }
    
    func getGenresForMovie(genresIds: [Int]) {
        self.mediaGenres.removeAll()
        for id in genresIds {
            for genre in self.movieGenres.genres {
                if id == genre.id {
                    self.mediaGenres.append(genre.name)
                    print("Added genre: \(genre.name)")
                }
            }
        }
        print("Media genres after filtering: \(mediaGenres)")
    }
    
    func getGenresForTv(genresIds: [Int]) {
        self.mediaGenres.removeAll()
        for id in genresIds {
            
            for genre in self.tvGenres {
                if (id == genre.id) {
                    self.mediaGenres.append(genre.name)
                }
            }
            
        }
        print("Media genres after filtering: \(mediaGenres)")
        
    }
}
