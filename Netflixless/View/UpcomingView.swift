//
//  UpcomingView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject private var vm: TMDBViewModel
    var body: some View {
        VStack{
            Divider()
            
            ScrollView {
                HStack() {
                    Text("Upcoming")
                        .bold()
                        .font(.headline)
                        .padding()
                    Spacer()
                }
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
