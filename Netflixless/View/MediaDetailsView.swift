//
//  MediaDetailsView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import SwiftUI

struct MediaDetailsView: View {
    @State private var imageModel: ImageModel = ImageModel()
    let media: any Media
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Rectangle()
                    .frame(width: .infinity,height: .infinity)
            }
        }
    }
}

#Preview {
    MediaDetailsView(media: Movie(
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
