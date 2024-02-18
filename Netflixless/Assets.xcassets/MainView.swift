//
//  MainView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 01/02/2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var loginLogoutViewModel = Login_LogoutViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    FavoriteView()
                        .tabItem {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.white)
                            Text("Favorites")
                        }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainView()
}
