//
//  ContentView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = TrendingsViewModel()
    @StateObject var en = TopRatedViewModel()
    @StateObject var dm = PopularViewModel()
    var body: some View {
        ScrollView {
            OnTheAir()
            VStack(alignment: .leading) {
                Text("Popular")
                    .bold()
                    .font(.headline)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(dm.shows, id: \.self){top in
                            PopularCard(show: top)
                        }
                    }
                }
                Text("Top rated")
                    .bold()
                    .font(.headline)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(en.topRated, id: \.self){top in
                            TopRatedCard(result: top)
                        }
                    }
                }
                Text("Trendings")
                    .bold()
                    .font(.headline)
                    .padding(.leading)
                trending
            }
             .onAppear{
                vm.fetchTrends()
                 en.fetchShows()
                 dm.fetchShows()
            }
        }
    }
    
    var trending: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.movies){trend in
                    TrendingsCard(trend: trend)                   
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
