//
//  SwiftUIView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 28/01/2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            StartShape()
            EndShape()
        }
        .background(LinearGradient(colors: [Color.blue,Color.black.opacity(0.7)], startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all))
        
    }
}

struct StartShape: View {
    @StateObject var movieModel = MovieModel()
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
                            .padding(.leading, 20)
                        Rectangle()
                            .fill(Color.black.opacity(0))
                            .frame(width: .infinity,height: .infinity)
                            
                    }
                    if movieModel.trendingMovies.indices.contains(randomTrendingMovie) {
                        let movie = movieModel.trendingMovies[randomTrendingMovie]
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



struct EndShape: View {
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.7))
            .frame(width: .infinity, height: .infinity)
            .overlay(
                ZStack(alignment: .leading) {
                    ScrollView(.horizontal) {
                        HStack{
                            
                        }
                    }
                }
            )
    }
}

#Preview {
    HomeView()
}
