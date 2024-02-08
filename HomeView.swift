//
//  SwiftUIView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 28/01/2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    RecommendedTrendingMovie()
                    MovieListsContainer()
                        .background(Color.black.opacity(0.7))
                }
            }
            .background(LinearGradient(colors: [Color.blue, Color.black.opacity(0.7)], startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all))
        }
}


struct RecommendedTrendingMovie: View {
    @StateObject private var movieModel: MovieModel = MovieModel()
    
    let randomTrendingMovie = Int.random(in: 0..<2)
    var body: some View{
        Rectangle()
            .fill(
                LinearGradient(colors: [Color.blue,Color.black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
            )
            .frame(width: .infinity, height: 450)
            .overlay(
                VStack(alignment: .center) {
                    HStack {
                        Text("NetflixLess")
                            .foregroundStyle(Color.white)
                            .font(.title.bold())
                            .padding(.top, 20)
                            .padding(.leading,20)
                        Rectangle()
                            .fill(Color.black.opacity(0))
                            .frame(width: .infinity,height: .infinity)
                            
                    }
                    
                    if movieModel.trendingMovies.results.indices.contains(randomTrendingMovie) {
                        let movie = movieModel.trendingMovies.results[randomTrendingMovie]
                        let path = movie.posterPath
                        RecommendedTrendingView(imgPath: path)
                    } else {
                        RecommendedTrendingView(imgPath: "")
                    }
                }
            )
        
            .onAppear {
                movieModel.fetchTrendingMovies()
            }
    }
}



struct MovieListsContainer: View {
    @StateObject private var movieModel: MovieModel = MovieModel()
    
    var body: some View {
        VStack {
            Text("UPCOMING")
                .font(.title3.bold())
                .foregroundColor(Color.white)
                .padding(.bottom, 10) // Ajoutez un espacement entre les deux textes
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movieModel.upcomingMovies.results) { movie in
                        MovieCardView(movie: movie)
                    }
                }
            }
            
            Text("POPULAR")
                .font(.title3.bold())
                .foregroundColor(Color.white)
                .padding(.top, 10) // Ajoutez un espacement entre les deux textes
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movieModel.popularMovies.results) { movie in
                        MovieCardView(movie: movie)
                    }
                }
            }
            
            Text("CURRENTLY PLAYING")
                .font(.title3.bold())
                .foregroundColor(Color.white)
                .padding(.top, 10) // Ajoutez un espacement entre les deux textes
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movieModel.currentlyPlayingMovies.results) { movie in
                        MovieCardView(movie: movie)
                    }
                }
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [Color.black.opacity(0.2),Color.black.opacity(1)], startPoint: .top, endPoint: .bottom)
        )
        .onAppear {
            movieModel.fetchUpcomingMovies()
            movieModel.fetchPopularMovies()
            movieModel.fetchCurrentlyPlayingMovies()
            print(movieModel.movies)
        }
    }
}

#Preview {
    HomeView()
}
