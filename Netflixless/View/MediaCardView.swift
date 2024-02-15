//
//  MovieCardView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 03/02/2024.
//

import SwiftUI

struct MediaCardView: View {
    let media: any Media
    let isHuman: Bool
    let humanPath: String?
    @StateObject var imageModel = ImageModel()

    var body: some View {
        NavigationLink(destination: MediaDetailsView(media: media)) {
            Rectangle()
                .frame(width: 100, height: 150)
                .overlay(
                    Group {
                        if isHuman {
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
                                            imageModel.fetchSmallImage(imgPath: humanPath ?? "")
                                        }
                                } else {
                                    Image(systemName: "video")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 200)
                                        .onAppear {
                                            imageModel.fetchSmallImage(imgPath: humanPath ?? "")
                                        }
                                }
                            }
                        } else {
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
                    }
                )
                .background(Color.black.opacity(0.3))
                .overlay(
                    
                    VStack {
                        if !isHuman {
                            Text(media.shortTitle)
                                .font(.headline.bold())
                                .foregroundStyle(Color.white.opacity(0.5))
                                .background(Color.black.opacity(0))
                        }
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
    
    MediaCardView(media:  Movie(
        adult: false,
        backdropPath: "/4qCqAdHcNKeAHcK8tJ8wNJZa9cx.jpg",
        id: 11,
        title: "Star Wars",
        originalLanguage: .en,
        originalTitle: "Star Wars",
        overview: "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.",
        posterPath: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
        mediaType: .movie,
        genreIDS: [12, 28, 878],
        popularity: 96.777,
        releaseDate: "1977-05-25",
        video: false,
        voteAverage: 8.205,
        voteCount: 19649,
        name: nil,
        originalName: nil,
        firstAirDate: nil,
        originCountry: nil,
        belongsToCollection: BelongsToCollection(
            id: 10,
            name: "Star Wars Collection",
            posterPath: "/r8Ph5MYXL04Qzu4QBbq2KjqwtkQ.jpg",
            backdropPath: "/d8duYyyC9J5T825Hg7grmaabfxQ.jpg"
        ),
        budget: 11000000,
        genres: [
            Genre(id: 12, name: "Adventure"),
            Genre(id: 28, name: "Action"),
            Genre(id: 878, name: "Science Fiction")
        ],
        homepage: "http://www.starwars.com/films/star-wars-episode-iv-a-new-hope",
        imdbID: "tt0076759",
        productionCompanies: [
            ProductionCompany(
                id: 1,
                logoPath: "/tlVSws0RvvtPBwViUyOFAO0vcQS.png",
                name: "Lucasfilm Ltd.",
                originCountry: "US"
            ),
            ProductionCompany(
                id: 25,
                logoPath: "/qZCc1lty5FzX30aOCVRBLzaVmcp.png",
                name: "20th Century Fox",
                originCountry: "US"
            )
        ],
        productionCountries: [
            ProductionCountry(iso3166_1: "US", name: "United States of America")
        ],
        revenue: 775398007,
        runtime: 121,
        spokenLanguages: [
            SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")
        ],
        status: "Released",
        tagline: "A long time ago in a galaxy far, far away...",
        credits: Credits(
            cast: [
                Cast(
                    adult: false,
                    gender: 2,
                    id: 2,
                    knownForDepartment: .acting,
                    name: "Mark Hamill",
                    originalName: "Mark Hamill",
                    popularity: 47.919,
                    profilePath: "/2ZulC2Ccq1yv3pemusks6Zlfy2s.jpg",
                    castID: 3,
                    character: "Luke Skywalker",
                    creditID: "52fe420dc3a36847f8000441",
                    order: 0, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 3,
                    knownForDepartment: .acting,
                    name: "Harrison Ford",
                    originalName: "Harrison Ford",
                    popularity: 57.309,
                    profilePath: "/zVnHagUvXkR2StdOtquEwsiwSVt.jpg",
                    castID: 4,
                    character: "Han Solo",
                    creditID: "52fe420dc3a36847f8000445",
                    order: 1, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 1,
                    id: 4,
                    knownForDepartment: .acting,
                    name: "Carrie Fisher",
                    originalName: "Carrie Fisher",
                    popularity: 17.589,
                    profilePath: "/d60ZwPUoizvw1gdU6dXvKUOeoDK.jpg",
                    castID: 5,
                    character: "Princess Leia Organa",
                    creditID: "52fe420dc3a36847f8000449",
                    order: 2, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 5,
                    knownForDepartment: .acting,
                    name: "Peter Cushing",
                    originalName: "Peter Cushing",
                    popularity: 16.391,
                    profilePath: "/if5g03wn6uvHx7F6FxXHLebKc0q.jpg",
                    castID: 6,
                    character: "Grand Moff Tarkin",
                    creditID: "52fe420dc3a36847f800044d",
                    order: 3, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 12248,
                    knownForDepartment: .acting,
                    name: "Alec Guinness",
                    originalName: "Alec Guinness",
                    popularity: 14.219,
                    profilePath: "/gplGgl6XERpvYdluiwY8GlxSdpi.jpg",
                    castID: 14,
                    character: "Obi-Wan \"Ben\" Kenobi",
                    creditID: "52fe420dc3a36847f8000477",
                    order: 4, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 6,
                    knownForDepartment: .acting,
                    name: "Anthony Daniels",
                    originalName: "Anthony Daniels",
                    popularity: 11.452,
                    profilePath: "/c876ZM5ObwYgXksrRWNNrL9KeZg.jpg",
                    castID: 7,
                    character: "C-3PO",
                    creditID: "52fe420dc3a36847f8000451",
                    order: 5, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 130,
                    knownForDepartment: .acting,
                    name: "Kenny Baker",
                    originalName: "Kenny Baker",
                    popularity: 7.251,
                    profilePath: "/uo3RorCoGDWHecLtqjviwzFExxR.jpg",
                    castID: 8,
                    character: "R2-D2",
                    creditID: "52fe420dc3a36847f8000455",
                    order: 6, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 24343,
                    knownForDepartment: .acting,
                    name: "Peter Mayhew",
                    originalName: "Peter Mayhew",
                    popularity: 2.418,
                    profilePath: "/bWv4RHLhjH6Ujrfhzm6ZC8ms3f2.jpg",
                    castID: 15,
                    character: "Chewbacca",
                    creditID: "52fe420dc3a36847f800047b",
                    order: 7, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 24342,
                    knownForDepartment: .acting,
                    name: "David Prowse",
                    originalName: "David Prowse",
                    popularity: 3.002,
                    profilePath: "/xTocYiKHlRYN8tfh8vyQFsRXC0K.jpg",
                    castID: 16,
                    character: "Darth Vader (performer)",
                    creditID: "52fe420dc3a36847f800047f",
                    order: 8, job: nil
                ),
                Cast(
                    adult: false,
                    gender: 2,
                    id: 15152,
                    knownForDepartment: .acting,
                    name: "James Earl Jones",
                    originalName: "James Earl Jones",
                    popularity: 26.812,
                    profilePath: "/oqMPIsXrl9SZkRfIKN08eFROmH6.jpg",
                    castID: 17,
                    character: "Darth Vader (voice) (uncredited)",
                    creditID: "52fe420dc3a36847f8000483",
                    order: 9, job: nil
                )
            ],
            crew: []
        ),
        hasCollection: false
    ),isHuman: false,humanPath: nil)
}
