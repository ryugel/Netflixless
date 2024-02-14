//
//  Favorites.swift
//  Netflixless
//
//  Created by Augustin Diabira on 14/02/2024.
//

import Foundation

struct Favorites {
    var fav:[TMDB]
}


class FavoritesViewModel: ObservableObject {
    @Published var favs: [TMDB] = []
    
    init() {
        fetchFavorites()
    }
    
    func addToFavorites(item: TMDB) {
        favs.append(item)
        saveFavorites()
    }
    
    func removeFromFavorites(item: TMDB) {
        if let index = favs.firstIndex(of: item) {
            favs.remove(at: index)
            saveFavorites()
        }
    }
    
    func fetchFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let favorites = try? JSONDecoder().decode([TMDB].self, from: data) {
            self.favs = favorites
        }
    }
    
    func saveFavorites() {
        if let data = try? JSONEncoder().encode(favs) {
            UserDefaults.standard.set(data, forKey: "favorites")
        }
    }
    func isFavorite(item: TMDB) -> Bool {
           return favs.contains(item)
       }
}

