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
   // @State var user:User
    var body: some View {
        VStack {
            
            if viewModel.searchText.isEmpty {
                ContentUnavailableView("Search", systemImage: "magnifyingglass", description: Text("Are you looking for something ?"))
            }else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
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
    var body: some View {
        VStack {
            LazyImage(url: URL(string: movie.imageUrl + (movie.posterPath ?? movie.backdropPath ?? ""))){image in
                
                if let image = image.image {
                image
                        .resizable()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
            } else {
                Image(.placeholder)
                    .resizable()
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
                }
            }
            .processors([.resize(size: .init(width: 100, height: 150))])
            .priority(.veryHigh)
            .pipeline(pipeline)
            
        }
    }
}

