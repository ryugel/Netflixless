//
//  RecommendedEntertainment.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 05/02/2024.
//

import SwiftUI

struct RecommendedTrendingView: View {
    let imgPath: String
    let media: any Media
    @StateObject var imageModel = ImageModel()
    
    var body: some View {
        NavigationLink(destination: MediaDetailsView(media: media)) {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.black.opacity(0.2))
                .frame(width: 400, height: 400)
                .overlay(
                    ZStack() {
                        if let imageData = imageModel.data, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 350)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .opacity(0.9)
                        } else {
                            if #available(iOS 17.0, *) {
                                Image(systemName: "slowmo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .symbolEffect(.variableColor, options: .repeating)
                                    .onAppear {
                                        imageModel.fetchNormalImage(imgPath: imgPath)
                                    }
                            } else {
                                Image(systemName: "slowmo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .onAppear {
                                        imageModel.fetchNormalImage(imgPath: imgPath)
                                    }
                            }
                            
                            
                        }
                        
                    }
                    
                )
                .onAppear {
                    imageModel.fetchNormalImage(imgPath: imgPath)
                }
        }
    }
}

#Preview {
    RecommendedTrendingView(imgPath: "/2RcBuU8cdxFxCJibbiYCGNLApfz.jpg",media: Movie(
        adult: false,
        backdropPath: "/exampleBackdropPath.jpg",
        id: 123,
        title: "Transformers : The last knight",
        originalLanguage: .en,
        originalTitle: "Example Original Title",
        overview: "This is an example movie overview.",
        posterPath: "/2RcBuU8cdxFxCJibbiYCGNLApfz.jpg",
        mediaType: .movie,
        genreIDS: [1, 2, 3],
        popularity: 7.5,
        releaseDate: "2022-01-01",
        video: true,
        voteAverage: 8.0,
        voteCount: 100,
        name: nil,
        originalName: nil,
        firstAirDate: nil,
        originCountry: nil
    ))
}