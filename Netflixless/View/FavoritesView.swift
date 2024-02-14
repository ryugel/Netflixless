//
//  FavoritesView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var vm = FavoritesViewModel()
    var body: some View {
        VStack {
            if vm.favs.isEmpty {
                ContentUnavailableView("No Favorites", systemImage: "heart.slash", description: Text("You have no favorites shows or movies yet. Feel free to add some."))
            } else {
                ScrollView {
                    ForEach(vm.favs){tmdb in
                            UpcomingRow(tmdb: tmdb)
                            
                    }
                    .padding()
                    Spacer()
                }
                
            }
        }.task{
            vm.fetchFavorites()
        }
    }
}

#Preview {
    FavoritesView()
}
