//
//  FavoritesView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct FavoritesView: View {
    @StateObject private var userViewModel = UserViewModel()
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack {
            if let favorites = userViewModel.user?.favorites, !favorites.isEmpty {
                ScrollView {
                    HStack() {
                        Text("Favorites")
                            .bold()
                            .font(.headline)
                            .padding()
                        Spacer()
                        Button {
                            userViewModel.removeAllFavorites()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                    if sizeClass == .regular && verticalSizeClass == .regular {
                        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 20) {
                            ForEach(favorites) { tmdb in
                                UpcomingRow(tmdb: tmdb)
                            }
                        }
                    } else {
                        LazyVStack {
                            ForEach(favorites) { tmdb in
                                UpcomingRow(tmdb: tmdb)
                            }
                        }
                    }
                }
            } else {
                ContentUnavailableView("No Favorites", systemImage: "heart.slash", description: Text("You have no favorite shows or movies yet. Feel free to add some."))
            }
        }
        .task {
            await userViewModel.fetchUser()
        }
    }
}


#Preview {
    FavoritesView()
}
