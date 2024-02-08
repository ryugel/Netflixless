//
//  MovieCardView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 03/02/2024.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    @StateObject var imageModel = ImageModel()
    
    
    
    var shortTitle: String {
            if let title = movie.title, !title.isEmpty {
                if title.count > 17 {
                    return String(title.prefix(17)) + "..."
                } else {
                    return title
                }
            } else if let name = movie.name, !name.isEmpty {
                if name.count > 17 {
                    return String(name.prefix(17)) + "..."
                } else {
                    return name
                }
            } else {
                return "..."
            }
        }
    
    var body: some View {
        Rectangle()
            .frame(width: 100,height: 150)
            .overlay(
                ZStack {
                    if let imageData = imageModel.data, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            

                    } else {
                        if #available(iOS 17.0, *) {
                            Image(systemName: "video")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .symbolEffect(.variableColor, options: .repeating)
                                .onAppear {
                                    imageModel.fetchSmallImage(imgPath: movie.posterPath)
                                }
                        } else {
                            Image(systemName: "video")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .onAppear {
                                    imageModel.fetchSmallImage(imgPath: movie.posterPath)
                                }
                        }
                    }
                }
            )
            .background(Color.black.opacity(0.3))
            .overlay(
                            VStack {
                                Text(shortTitle)
                                    .font(.headline.bold())
                                    .foregroundStyle(Color.white.opacity(0.5))
                                    .background(Color.black.opacity(0))
                            }
                        )
        
    }
    
}

#Preview {
    
    MovieCardView(movie: Movie(
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
