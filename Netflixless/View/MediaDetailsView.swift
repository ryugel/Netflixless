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
    @StateObject private var movieModel: MovieModel = MovieModel()
    @State private var isFavorite: Bool = false
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
                                            imageModel.fetchSmallImage(imgPath: movieModel.movie.posterPath)
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
                                            imageModel.fetchSmallImage(imgPath: movieModel.movie.posterPath)
                                        }
                                    }
                            }
                        }
                        Text(media.title?.uppercased() ?? media.name?.uppercased() ?? "")
                            .font(.title.bold())
                            .foregroundStyle(Color.white)
                            .padding(.bottom, 10)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .padding(.top, -85)

                        HStack {
                            ForEach(genreModel.mediaGenres, id: \.self) { genre in
                                Text(genre)
                                    .font(.subheadline.bold())
                                    .foregroundStyle(Color.white.opacity(0.5))
                            }
                        }
                        
                        Button(action: {
                            isFavorite.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: geometry.size.width - 100,height: 44)
                                .foregroundColor(isFavorite ? Color.gray : Color.red)
                                .overlay(
                                    Text(isFavorite ? "Remove from Favourites" : "Add to Favourites")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                )
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        HStack {
                            Text("Release Date : \(media.releaseDate ?? media.firstAirDate ?? "N/A") ")
                                .foregroundStyle(Color.white)
                                .font(.subheadline.italic())
                            if (media.mediaType?.rawValue == "movie") {
                                
                            }else if (media.mediaType?.rawValue == "tv") {
                                
                            }else {
                                
                            }
                            
                        }
                        Text("Overview: \n\n\(media.overview)")
                            .font(.callout)
                            .foregroundStyle(Color.white)
                            .padding(.top,20)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                        
                    }
              
                }
            }
            .edgesIgnoringSafeArea(.top)
            .background(
                LinearGradient(colors: [Color.gray.opacity(0.3),Color.black], startPoint: UnitPoint.top, endPoint: .bottom)
            )
            .onAppear {
                genreModel.getGenresForMedia(genresIds: movieModel.movie.genreIDS ?? [1])
            }
        }
        .onAppear {
            if let path = media.backdropPath, !path.isEmpty {
                imageModel.fetchSmallImage(imgPath: path)
            }else {
                imageModel.fetchSmallImage(imgPath: media.posterPath)
            }
            
            genreModel.getGenresForMedia(genresIds: media.genreIDS ?? [1])
            movieModel.fetchMovieDetailsById(movieId: media.id as! Int)
            
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
