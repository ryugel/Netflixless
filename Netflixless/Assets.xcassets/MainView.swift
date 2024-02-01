//
//  MainView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 01/02/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        TabView{
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            FavoriteView()
                .tabItem() {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.white)
                    Text("Favorites")
                }
            ProfileView()
                .tabItem () {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
        }
        
    }
}

#Preview {
    MainView()
}
