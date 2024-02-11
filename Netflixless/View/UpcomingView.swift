//
//  UpcomingView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI

struct UpcomingView: View {
    @StateObject private var vm = TMDBViewModel()
    var body: some View {
        VStack{
            Divider()
            
            ScrollView {
                Text("Upcoming")
                    .bold()
                    .font(.title)
                    .padding(.leading)
                ForEach(vm.upcoming){upcoming in
                    UpcomingRow(tmdb: upcoming)
                }
            }
            .task {
                vm.fetchTMDBData(tmdbUrl: .upcoming)
            }
            .navigationTitle("Upcoming")
            .scrollIndicators(.hidden)
        }.padding(.bottom)
    }
}

#Preview {
    UpcomingView()
}
