//
//  TabView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI
import Kingfisher
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View {
    @State  var myProfile:User?
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
            } .task {
                do {
                    await getUser()
                    print(myProfile?.username)
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
                
                ZStack {
                    KFImage(myProfile?.pictureURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                    
                    
                }
                
            }
                                
            )
        }
    }
    
    func getUser() async  {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else { return }
        await MainActor.run {
            myProfile = user
        }
    }
}
