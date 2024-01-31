//
//  ContentView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = TrendingsViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText.isEmpty ? vm.movies : vm.movies.filter {
                    return $0.title?.lowercased().contains(searchText.lowercased()) ?? false
                }){movie in
                    Text(movie.title ?? "this movie's title is not in our DB! Apologize")
                }
                
            } .onAppear{
                // When the View appears I'm fetching data from API.
                vm.fetchTrends()
            }
            .navigationTitle("Trendings")
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    ContentView()
}
