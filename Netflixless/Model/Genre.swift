//
//  Genre.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 09/02/2024.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable,Equatable,Hashable {
    let id: Int
    let name: String
    
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

extension Genres: Sequence {
    func makeIterator() -> IndexingIterator<[Genre]> {
        return genres.makeIterator()
    }
}
