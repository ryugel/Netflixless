//
//  GenreModel.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 09/02/2024.
//

import Foundation

class GenreModel: ObservableObject {
    let genresArray = [
        Genre(id: 28, name: "Action"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"),
        Genre(id: 99, name: "Documentary"),
        Genre(id: 18, name: "Drama"),
        Genre(id: 10751, name: "Family"),
        Genre(id: 14, name: "Fantasy"),
        Genre(id: 36, name: "History"),
        Genre(id: 27, name: "Horror"),
        Genre(id: 10402, name: "Music"),
        Genre(id: 9648, name: "Mystery"),
        Genre(id: 10749, name: "Romance"),
        Genre(id: 878, name: "Science Fiction"),
        Genre(id: 10770, name: "TV Movie"),
        Genre(id: 53, name: "Thriller"),
        Genre(id: 10752, name: "War"),
        Genre(id: 37, name: "Western"),
        Genre(id: 10759, name: "Action & Adventure"),
        Genre(id: 10762, name: "Kids"),
        Genre(id: 10763, name: "News"),
        Genre(id: 10764, name: "Reality"),
        Genre(id: 10765, name: "Sci-Fi & Fantasy"),
        Genre(id: 10766, name: "Soap"),
        Genre(id: 10767, name: "Talk"),
        Genre(id: 10768, name: "War & Politics")
    ]

    @Published var mediaGenres: [String] = []
    
    func getGenresForMedia(genresIds: [Int]) {
        if genresIds.first != 1 {
            self.mediaGenres.removeAll()
        }
            for id in genresIds {
                for genre in genresArray {
                    if id == genre.id {
                        self.mediaGenres.append(genre.name)
                        print("Added genre: \(genre.name)")
                    }
                }
            }

            
        }

}
