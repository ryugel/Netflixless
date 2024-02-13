//
//  ProfileView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 13/02/2024.
//

import SwiftUI
import Kingfisher
import FirebaseAuth

struct ProfileView: View {
    @State  var myProfile: User
    
    @AppStorage("is_logged") var isLogged = false
    var body: some View {
        VStack {
            KFImage(myProfile.pictureURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 125, height: 125)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 10)
                .padding(.bottom, 20)
            
            Text(myProfile.username)
                .font(.title)
                .bold()
                .padding(.bottom, 30)
            
            Spacer()
            
            VStack(spacing: 20) {
                ProfileOptionButton(title: "Account", action: {
                   
                })
                ProfileOptionButton(title: "App Settings", action: {
                  
                })
                ProfileOptionButton(title: "Notifications", action: {
                    
                })
                ProfileOptionButton(title: "Log out", action: {
                   logOut()
                })
            }
        }
        .padding()
        .preferredColorScheme(.dark)
    }
    
    func logOut(){
        try? Auth.auth().signOut()
        isLogged = false
    }
}

struct ProfileOptionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)  
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    ProfileView(myProfile: User(userUID: "aakla,", username: "Tyla", email: "Tyla@gmail.com", pictureURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/netflixless-df59e.appspot.com/o/Profile_Images%2FKDSFTTMz1NQ8exGelTUCLrQifn22?alt=media&token=a6c26bdc-fbf0-485f-8109-2c3940787b97")!, password: ""))
}
