//
//  MediaProtocol.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import Foundation

protocol Media: Identifiable, Hashable, Codable {
    var title: String? { get }
    var name: String? { get }
    var posterPath: String { get }
    var mediaType: MediaType? { get }
    var backdropPath: String? {get}
    var genreIDS: [Int]? { get } 
    var overview: String {get}
    var releaseDate: String? { get }
    var firstAirDate: String? { get }
    var runtime: Int? {get}
    
}


extension Media {
    var shortTitle: String {
        if let title = self.title, !title.isEmpty {
            if title.count > 17 {
                return String(title.prefix(17)) + "..."
            } else {
                return title
            }
        } else if let name = self.name, !name.isEmpty {
            if name.count > 17 {
                return String(name.prefix(17)) + "..."
            } else {
                return name
            }
        } else {
            return "..."
        }
    }
}
