//
//  TabView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import NukeUI
import Nuke

struct HomeView: View {
    @State  var myProfile:User?
    @EnvironmentObject private var vm: TMDBViewModel
    private let pipeline = ImagePipeline {
        $0.dataCache = try? DataCache(name: "com.myapp.datacache")
        $0.dataCachePolicy = .storeOriginalData
    }
    var body: some View {
        NavigationStack {
            TabView {
                Home()
                    .tabItem {
                        Image(systemName: "house")
                    }
                UpcomingView()
                    .environmentObject(vm)
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
                NavigationLink {
                    myProfile.map { ProfileView(myProfile: $0) }
                } label: {
                    LazyImage(url: myProfile?.pictureURL){image in
                        image.image?
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                    }
                    .pipeline(pipeline)
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

