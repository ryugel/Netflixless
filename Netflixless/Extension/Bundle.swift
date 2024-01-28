//
//  Bundle.swift
//  Netflixless
//
//  Created by Augustin Diabira on 23/01/2024.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in bundle")
        }
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not find \(file) in bundle")
        }
        return decodedData
    }
}
