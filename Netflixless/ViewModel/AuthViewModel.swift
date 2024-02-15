//
//  AuthViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 14/02/2024.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showError = false
    @Published var errorMsg = ""
    @Published var isLoading = false
    @Published var createAccount = false
    @Published var alert = false
    @AppStorage("is_logged") var isLogged = false
    @AppStorage("image_URL") var imageUrl: URL?
    @AppStorage("user_pseudo") var userpseudo = ""
    @AppStorage("user_UID") var userUID = ""
    
    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.isLoading = false
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
            } else {
                self.fetchUser()
            }
        }
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
            } else {
                self.alert = true
            }
        }
    }
    
    private func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Users").document(userID).getDocument { document, error in
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
            } else if let document = document, document.exists {
                if let user = try? document.data(as: User.self) {
                    self.userpseudo = user.username
                    self.userUID = userID
                    self.imageUrl = user.pictureURL
                    self.isLogged = true
                }
            }
        }
    }
}

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var password2: String = ""
    @Published var ProfilePic: Data?
    @Published var showError = false
    @Published var errorMsg = ""
    @Published var isLoading = false
    @Published var showImagePicker = false
    @Published var photoItem:PhotosPickerItem?
    @AppStorage("is_logged") var isLogged = false
    @AppStorage("image_URL") var imageUrl: URL?
    @AppStorage("user_pseudo") var userpseudo = ""
    @AppStorage("user_UID") var userUID = ""
    
    
    func condition() -> Bool {
           return userName.isEmpty || email.isEmpty || password.isEmpty || password != password2 || password.count <= 8 || ProfilePic == nil
       }
    
    func registerAccount() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
                self.isLoading = false
                return
            }
            
            guard let userID = Auth.auth().currentUser?.uid else { return }
            guard let imageData = self.ProfilePic else { return }
            
            let storageRef = Storage.storage().reference().child("Profile_Images").child(userID)
            let _ = storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    self.errorMsg = error.localizedDescription
                    self.showError = true
                    self.isLoading = false
                    return
                }
                
                storageRef.downloadURL { url, error in
                    if let error = error {
                        self.errorMsg = error.localizedDescription
                        self.showError = true
                        self.isLoading = false
                        return
                    }
                    
                    guard let downloadUrl = url else {
                        self.errorMsg = "Failed to get download URL."
                        self.showError = true
                        self.isLoading = false
                        return
                    }
                    
                    let user = User(userUID: userID, username: self.userName, email: self.email, pictureURL: downloadUrl, password: self.password, favorites: [])
                    
                    try? Firestore.firestore().collection("Users").document(userID).setData(from: user) { error in
                        if let error = error {
                            self.errorMsg = error.localizedDescription
                            self.showError = true
                            self.isLoading = false
                            return
                        }
                        
                        self.userpseudo = self.userName
                        self.userUID = userID
                        self.imageUrl = downloadUrl
                        self.isLogged = true
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
