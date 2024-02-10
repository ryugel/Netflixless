//
//  MovieCardView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 03/02/2024.
//

import SwiftUI

struct MediaCardView: View {
    let media: any Media
    @StateObject var imageModel = ImageModel()

    var body: some View {
        NavigationLink(destination: MediaDetailsView(media: media)) {
            Rectangle()
                .frame(width: 100, height: 150)
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
                                        imageModel.fetchSmallImage(imgPath: media.posterPath)
                                    }
                            } else {
                                Image(systemName: "video")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .onAppear {
                                        imageModel.fetchSmallImage(imgPath: media.posterPath)
                                    }
                            }
                        }
                    }
                )
                .background(Color.black.opacity(0.3))
                .overlay(
                    VStack {
                        Text(media.shortTitle)
                            .font(.headline.bold())
                            .foregroundStyle(Color.white.opacity(0.5))
                            .background(Color.black.opacity(0))
                    }
                )
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)) 
                .onAppear {
                    print("genres : \(media.genreIDS ?? [1])")
                }
        }
    }
}

#Preview {
    
    MediaCardView(media: Movie(
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
        originCountry: nil,
        belongsToCollection: nil,
        budget: nil,
        genres: nil,
        homepage: nil,
        imdbID: nil,
        productionCompanies: nil,
        productionCountries: nil,
        revenue: nil,
        runtime: nil,
        spokenLanguages: nil,
        status: nil,
        tagline: nil
    ))
}
