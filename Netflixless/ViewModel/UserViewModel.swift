//
//  UserViewModel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 15/02/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var user: User?
    private var db = Firestore.firestore()
    
    func fetchUser() async {
        do {
            if let userUID = Auth.auth().currentUser?.uid {
                let documentSnapshot = try await db.collection("Users").document(userUID).getDocument()
                try await MainActor.run {
                    self.user = try documentSnapshot.data(as: User.self)
                }
            }
        } catch {
            print("Error fetching user: \(error)")
        }
    }
    
    func addToFavorites(_ item: TMDB) {
        guard var currentUser = user else { return }
        currentUser.addToFavorites(item)
        updateUser(currentUser)
    }
    
    func removeFromFavorites(_ item: TMDB) {
        guard var currentUser = user else { return }
        currentUser.removeFromFavorites(item)
        updateUser(currentUser)
    }
    
    private func updateUser(_ user: User) {
        let userID = user.userUID 
        do {
            try db.collection("Users").document(userID).setData(from: user)
        } catch let error {
            print("Error updating user: \(error)")
        }
    }
}
