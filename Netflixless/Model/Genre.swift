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

struct Genre: Codable {
    let id: Int
    let name: String
}

extension Genres: Sequence {
    func makeIterator() -> IndexingIterator<[Genre]> {
        return genres.makeIterator()
    }
}
