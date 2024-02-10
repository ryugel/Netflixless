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
    @StateObject var ko = UpcomingViewModel()
    var body: some View {
        NavigationView {
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
                    Text("Upcoming")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(ko.upcomings, id: \.self){upcoming in
                                UpcomingCard(upcomingShow: upcoming)
                            }
                        }
                    }
                    Text("Trendings")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    trending
                } }
            .navigationBarItems(leading:
                           Text("Netflixless")
                               .font(.largeTitle).bold()
                               .foregroundColor(Color.color1) 
                               .padding(.leading, 13)
                       )
            .onAppear{
                vm.fetchTrends()
                en.fetchShows()
                dm.fetchShows()
                ko.fetchUpcomingShows()
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
