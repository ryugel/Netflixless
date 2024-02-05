//
//  ImageModel.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 05/02/2024.
//

import Foundation

class ImageModel: ObservableObject {
    
    @Published var data: Data?
    
    private var originalImageUrl = "https://image.tmdb.org/t/p/original/"
    
    private let smallImageUrl = "https://image.tmdb.org/t/p/w500/"
    
    
    
    func createUrl(imgPath: String,  normal: Bool) -> URL {
        
        if (normal) {
            let urlString  = originalImageUrl + imgPath
            guard let url = URL(string: urlString) else {
                fatalError("Invalid IMG URL")
            }
            return url
        }else {
            let urlString = smallImageUrl + imgPath
            guard let url = URL(string: urlString + imgPath) else {
                fatalError("Invalid IMG URL")
            }
            return url
        }
    }
    
    
    func fetchNormalImage(imgPath: String) {
        let url = createUrl(imgPath: imgPath, normal: true)
        
        let request = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        
        request.resume()
    }
    
    func fetchSmallImage(imgPath: String) {
        let url = createUrl(imgPath: imgPath, normal: false)
        
        let request = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        
        request.resume()
    }
    
    
}
