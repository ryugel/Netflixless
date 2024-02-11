//
//  SearchingView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
           
            if viewModel.searchText.isEmpty {
               ContentUnavailableView("Search", systemImage: "magnifyingglass", description: Text("Are you looking for something ?"))
            }else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(viewModel.searchedMovies) { movie in
                            MovieItemView(movie: movie)
                        }
                    }
                    .padding()
                }
            }
           
        }
        .navigationBarItems(leading:  SearchBar(txt: $viewModel.searchText))
        .onAppear {
            viewModel.searchTMDB()
        }
    }
}

struct MovieItemView: View {
    let movie: TMDB
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.imageUrl + (movie.posterPath ?? ""))) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "interrogation.mark")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
#Preview {
    SearchView()
}
