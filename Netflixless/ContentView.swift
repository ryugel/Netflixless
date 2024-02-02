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
    @State private var searchText = ""
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Top rated")
                .bold()
                .font(.largeTitle)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(en.topRated, id: \.self){top in
                        TopRatedCard(result: top)
                    }
                }
            }
            //Spacer()
            Text("Trendings")
                .bold()
                .font(.largeTitle)
                .padding(.leading)
            trending
             .onAppear{
                // When the View appears I'm fetching data from API.
                vm.fetchTrends()
                 en.fetchShows()
            }
            .navigationTitle("Trendings")
        }
    }
    
    var trending: some View {
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.movies){trend in
                    TrendingsCard(trend: trend)                    }
            }
        }
    }
}
//
//ForEach(searchText.isEmpty ? vm.movies : vm.movies.filter {
//    return $0.title?.lowercased().contains(searchText.lowercased()) ?? false
//}){movie in
//    Text(movie.title ?? "this movie's title is not in our DB! Apologize")
//}

#Preview {
    ContentView()
}
