//
//  UpcomingView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject private var vm: TMDBViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack {
            Divider()
            
            ScrollView {
                HStack() {
                    Text("Upcoming")
                        .bold()
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                if sizeClass == .regular {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 20) {
                        ForEach(vm.upcoming) { upcoming in
                            UpcomingRow(tmdb: upcoming)
                        }
                    }
                } else {
                    ForEach(vm.upcoming) { upcoming in
                        UpcomingRow(tmdb: upcoming)
                    }
                }
            }
            .task {
                vm.fetchTMDBData(tmdbUrl: .upcoming)
            }
            .navigationTitle("Upcoming")
            .scrollIndicators(.hidden)
        }
        .padding(.bottom)
    }
}
#Preview {
    UpcomingView()
}
