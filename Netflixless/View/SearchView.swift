//
//  SearchingView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI
import NukeUI
import Nuke

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    var body: some View {
        VStack {
            
            if viewModel.searchText.isEmpty {
                ContentUnavailableView("Search", systemImage: "magnifyingglass", description: Text("Are you looking for something ?"))
            }else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(viewModel.searchedMovies) { movie in
                            NavigationLink {
                                TMDBDetailView(show: movie)
                            } label: {
                                MovieItemView(movie: movie)
                            }
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
    private let pipeline = ImagePipeline {
        $0.dataCache = try? DataCache(name: "com.myapp.datacache")
        $0.dataCachePolicy = .storeOriginalData
    }
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack {
            LazyImage(url: URL(string: movie.imageUrl + (movie.posterPath ?? movie.backdropPath ?? ""))) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: sizeClass == .regular ? 300 : 100, height: sizeClass == .regular ? 425 : 150)
                        .cornerRadius(10)
                } else {
                    Image(.placeholder)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: sizeClass == .regular ? 300 : 100, height: sizeClass == .regular ? 225 : 150)
                        .cornerRadius(10)
                }
            }
            .processors([.resize(size: .init(width: sizeClass == .regular ? 300 : 100, height: sizeClass == .regular ? 425 : 150))])
        }
    }
}
