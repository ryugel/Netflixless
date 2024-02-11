//
//  ContentView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import SwiftUI

struct Home:View {
    @StateObject private var vm = TMDBViewModel()
    var body: some View {
        VStack {
            ScrollView {
                AiringView()
                VStack(alignment: .leading) {
                    Text("Popular")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(vm.popular, id: \.self){top in
                                TMDBCard(tmdb: top)
                            }
                        }
                    }
                    Text("Top rated")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(vm.topRated, id: \.self){top in
                                TMDBCard(tmdb: top)
                            }
                        }
                    }
                    Text("Upcoming")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(vm.upcoming, id: \.self){upcoming in
                                TMDBCard(tmdb: upcoming)
                            }
                        }
                    }
                    Text("Trendings")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    trending
                } }
           
            .scrollIndicators(.hidden)
            .task{
                vm.fetchTMDBData(tmdbUrl: .popular)
                vm.fetchTMDBData(tmdbUrl: .topRated)
                vm.fetchTMDBData(tmdbUrl: .upcoming)
                vm.fetchTMDBData(tmdbUrl: .trending)
            }
        }
    }
    var trending: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.trendings){trend in
                    TMDBCard(tmdb: trend)
                }
            }
        }
    }
}

#Preview {
    Home()
}
