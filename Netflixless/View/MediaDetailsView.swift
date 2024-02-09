//
//  MediaDetailsView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import SwiftUI

struct MediaDetailsView: View {
    @StateObject private var imageModel: ImageModel = ImageModel()
    @StateObject private var genreModel: GenreModel = GenreModel()
    let media: any Media
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                GeometryReader { geometry in
                    VStack {
                        if let imageData = imageModel.data, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: UIScreen.main.bounds.height / 2)
                                .opacity(1)
                                .mask(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1), Color.clear.opacity(0.1)]), startPoint: .center, endPoint: .bottom)
                                )
                        } else {
                            if #available(iOS 17.0, *) {
                                Image(systemName: "slowmo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height: 100)
                                    .symbolEffect(.variableColor, options: .repeating)
                                    .onAppear {
                                        if let path = media.backdropPath, !path.isEmpty {
                                            imageModel.fetchSmallImage(imgPath: path)
                                        }else {
                                            imageModel.fetchSmallImage(imgPath: media.posterPath)
                                        }
                                    }
                            } else {
                                Image(systemName: "slowmo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height: 100)
                                    .onAppear {
                                        if let path = media.backdropPath, !path.isEmpty {
                                            imageModel.fetchSmallImage(imgPath: path)
                                        }else {
                                            imageModel.fetchSmallImage(imgPath: media.posterPath)
                                        }
                                    }
                            }
                        }
                        Text(media.title?.uppercased() ?? media.name?.uppercased() ?? "")
                            .font(.title.bold())
                            .foregroundStyle(Color.white)
                            .padding(.bottom , 10)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                        HStack {
                            ForEach(genreModel.mediaGenres, id: \.self) { genre in
                                Text(genre)
                                    .font(.subheadline.bold())
                                    .foregroundStyle(Color.white.opacity(0.5))
                            }
                        }
                    }
                    .onAppear {
                        switch media.mediaType {
                            case .movie:
                                genreModel.fetchMovieGenres()
                            print(genreModel.movieGenres.genres)
                                break
                            case .tv:
                                genreModel.fetchTvGenres()
                                break
                            case .none:
                                genreModel.fetchMovieGenres()
                                genreModel.fetchTvGenres()
                                break
                        }
                    }
                    .onReceive(genreModel.$movieGenres) { genres in
                        genreModel.getGenresForMovie(genresIds: media.genreIDS)
                    }
                    .onReceive(genreModel.$tvGenres) { genres in
                        genreModel.getGenresForTv(genresIds: media.genreIDS)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .background(
                LinearGradient(colors: [Color.gray.opacity(0.3),Color.black], startPoint: UnitPoint.top, endPoint: .bottom)
            )
            
        }
        .onAppear {
            if let path = media.backdropPath, !path.isEmpty {
                imageModel.fetchSmallImage(imgPath: path)
            }else {
                imageModel.fetchSmallImage(imgPath: media.posterPath)
            }
            
            if let type = media.mediaType {
                switch type {
                case .movie:
                    print("a")
                    genreModel.fetchMovieGenres()
                    break
                case .tv:
                    print("b")
                    genreModel.fetchTvGenres()
                    break
                }
            }
            
            print("details genresids : \(media.genreIDS)" )
        }
        .onReceive(genreModel.$movieGenres) { genres in
            genreModel.getGenresForMovie(genresIds: media.genreIDS)
        }
        .onReceive(genreModel.$tvGenres) { genres in
            genreModel.getGenresForTv(genresIds: media.genreIDS)
        }
    }
}
#Preview {
    MediaDetailsView(media: Movie(
        adult: false,
        backdropPath: "/5vDuLrjJXFS9PTF7Q1xzobmYKR9.jpg",
        id: 123,
        title: "Star wars",
        originalLanguage: .en,
        originalTitle: "Example Original Title",
        overview: "This is an example movie overview.",
        posterPath: "/2RcBuU8cdxFxCJibbiYCGNLApfz.jpg",
        mediaType: .movie,
        genreIDS: [12, 28, 878],
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
