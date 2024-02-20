//
//  ProfileView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 13/02/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import NukeUI
import Nuke

struct ProfileView: View {
    @State  var myProfile: User
    @State var showError = false
    @State var errorMsg = ""
    @State var isLoading = false
    @State var alert = false
    private let pipeline = ImagePipeline {
        $0.dataCache = try? DataCache(name: "com.myapp.datacache")
        $0.dataCachePolicy = .storeOriginalData
    }
    
    @AppStorage("is_logged") var isLogged = false
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
           VStack {
               LazyImage(url: myProfile.pictureURL){ image in
                   image.image?
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: sizeClass == .regular ? 200 : 125, height: sizeClass == .regular ? 200 : 125) 
                       .clipShape(Circle())
                       .overlay(Circle().stroke(Color.white, lineWidth: 2))
                       .shadow(radius: 10)
                       .padding(.bottom, sizeClass == .regular ? 40 : 20)
               }
               .processors([.resize(size: .init(width: sizeClass == .regular ? 200 : 125, height: sizeClass == .regular ? 200 : 125))])
               .pipeline(pipeline)
               
               Text(myProfile.username)
                   .font(.title)
                   .bold()
                   .padding(.bottom, sizeClass == .regular ? 60 : 30)
               
               Spacer()
               
               VStack(spacing: sizeClass == .regular ? 40 : 20) {
                   ProfileOptionButton(title: "Reset Password", action: {
                       resetPassword()
                   })
                   ProfileOptionButton(title: "Delete Account", action: {
                       deleteAccount()
                   })
                   ProfileOptionButton(title: "Log out", action: {
                       logOut()
                   })
               }
           }
           .overlay{
               LoadingView(showing: $isLoading)
           }
           .padding()
           .preferredColorScheme(.dark)
           .alert(errorMsg, isPresented: $showError){}
           .alert("Link sent", isPresented: $alert){}
       }
    
    func logOut(){
        try? Auth.auth().signOut()
        isLogged = false
    }
    func deleteAccount(){
        isLoading = true
        Task {
            do {
                guard let userID = Auth.auth().currentUser?.uid else { return }
                let reference = Storage.storage().reference().child("Profile_Images").child(userID)
                try await reference.delete()
                try await Firestore.firestore().collection("Users").document(userID).delete()
                try await Auth.auth().currentUser?.delete()
                isLogged = false
            }catch {
                await displayErrorMsg(error)
            }
        }
    }
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: myProfile.email) { error in
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
            } else {
                self.alert = true
            }
        }
    }
    func displayErrorMsg(_ error: Error)async {
        await MainActor.run(body: {
            errorMsg = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

struct ProfileOptionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(title.contains("Delete") ? .red:.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    ProfileView(myProfile: User(userUID: "aakla,", username: "Tyla", email: "Tyla@gmail.com", pictureURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/netflixless-df59e.appspot.com/o/Profile_Images%2FKDSFTTMz1NQ8exGelTUCLrQifn22?alt=media&token=a6c26bdc-fbf0-485f-8109-2c3940787b97")!, password: "", favorites: []))
}
