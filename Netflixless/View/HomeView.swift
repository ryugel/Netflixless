//
//  TabView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            TabView {
                Home()
                    .tabItem {
                        Image(systemName: "house")
                    }
                UpcomingView()
                    .tabItem {
                        Image(systemName: "clock.fill")
                                  
                    }
                FavoritesView()
                            .tabItem {
                                Image(systemName: "heart")
                            }
            }
            .navigationBarItems(leading:
                                    HStack(spacing: 26){
                Text("Netflixless")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color.color1)
                    .padding(.leading, 13)
                Spacer()
                NavigationLink {
                    SearchView()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body)
                        .foregroundColor(.white)
                }

                Image(systemName: "person")
               
            }
                                
            )
        }
    }
}
