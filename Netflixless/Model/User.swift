//
//  User.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//


import SwiftUI
import FirebaseFirestoreSwift


struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var userUID: String
    var username:String
    var email:String
    var pictureURL:URL
    var password:String
    var favorites:[TMDB]
    
    enum CodingKeys: CodingKey {
    case id
    case userUID
    case username
    case email
    case pictureURL
    case password
    case favorites
    }
    
    mutating func addToFavorites(_ item: TMDB) {
            if !favorites.contains(item) {
                favorites.append(item)
            }
        }

        mutating func removeFromFavorites(_ item: TMDB) {
            if let index = favorites.firstIndex(of: item) {
                favorites.remove(at: index)
            }
        }
}
