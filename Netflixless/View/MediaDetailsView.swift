//
//  MediaDetailsView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 08/02/2024.
//

import SwiftUI

struct MediaDetailsView: View {
    @StateObject private var logoModel: ImageModel = ImageModel()
    @StateObject private var castModel: ImageModel = ImageModel()
    @StateObject private var directorModel: ImageModel = ImageModel()
    @StateObject private var imageModel: ImageModel = ImageModel()
    @StateObject private var genreModel: GenreModel = GenreModel()
    @StateObject private var movieModel: MovieModel = MovieModel()
    @StateObject private var tvModel: TVShowModel = TVShowModel()
    @State private var isFavorite: Bool = false
    @State private var detailsBtn: Bool = true
    @State private var seasonsBtn: Bool = false
    @State private var productionBtn: Bool = false
    @State private var collectionBtn: Bool = false
    
    
    let media: any Media
    
    func updateButtonsStates(selectedButton: String) {
        detailsBtn = selectedButton == "details"
        seasonsBtn = selectedButton == "seasons"
        productionBtn = selectedButton == "production"
        collectionBtn = selectedButton == "collection"
    }

    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                
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
                                            imageModel.fetchNormalImage(imgPath: path)
                                        }else {
                                            if let mediaType = media.mediaType {
                                                switch mediaType {
                                                case .movie:
                                                    imageModel.fetchNormalImage(imgPath: movieModel.movie.posterPath)
                                                case .tv :
                                                    imageModel.fetchNormalImage(imgPath: tvModel.tvShow.posterPath)
                                                }
                                            }
                                        }
                                    }
                            } else {
                                Image(systemName: "slowmo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height: 100)
                                    .onAppear {
                                        if let path = media.backdropPath, !path.isEmpty {
                                            imageModel.fetchNormalImage(imgPath: path)
                                        }else {
                                            if let mediaType = media.mediaType {
                                                switch mediaType {
                                                case .movie:
                                                    imageModel.fetchNormalImage(imgPath: movieModel.movie.posterPath)
                                                case .tv :
                                                    imageModel.fetchNormalImage(imgPath: tvModel.tvShow.posterPath)
                                                }
                                            }
                                        }
                                    }
                            }
                        }
                        
                        if let mediaType = media.mediaType {
                            switch mediaType {
                                case .movie:
                                Text(movieModel.movie.title?.uppercased() ?? movieModel.movie.name?.uppercased() ?? "")
                                    .font(.title.bold())
                                    .foregroundStyle(Color.white)
                                    .padding(.bottom, 10)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, -85)
                                case .tv:
                                Text(tvModel.tvShow.title?.uppercased() ?? tvModel.tvShow.name?.uppercased() ?? "")
                                    .font(.title.bold())
                                    .foregroundStyle(Color.white)
                                    .padding(.bottom, 10)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, -85)
                            }
                        }
                        HStack {
                            ForEach(genreModel.mediaGenres, id: \.self) { genre in
                                Text(genre)
                                    .font(.subheadline.bold())
                                    .foregroundStyle(Color.white.opacity(0.5))
                                    .padding(.bottom,10)
                            }
                        }
                        
                        .onAppear {
                            print("Initial mediaGenres:", genreModel.mediaGenres)
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
                                .shadow(radius: 20)
                            }
                            .padding(.bottom, 20)
                        if let mediaType = media.mediaType {
                            switch mediaType {
                                case .movie:
                                    if let video = movieModel.movie.video, video {
                                        Button(action: {
                                            
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: geometry.size.width * 0.4,height: 45)
                                                .foregroundColor(Color.gray)
                                                .overlay(
                                                    HStack {
                                                        Image(systemName: "play.rectangle")
                                                            .imageScale(.medium)
                                                            .foregroundStyle(Color.white)
                                                        Text("Watch trailler")
                                                            .font(.subheadline.italic())
                                                            .foregroundColor(Color.white)
                                                    }
                                                )
                                                .shadow(radius: 10)
                                                
                                            }
                                            .padding(.bottom, 20)
                                    }
                                case .tv:
                                    Spacer()
                            }
                        }
                        
                        HStack {
                            Text("Release Date : \(media.releaseDate ?? media.firstAirDate ?? "N/A") ")
                                .foregroundStyle(Color.white)
                                .font(.subheadline.italic())
                            if let mediaType = media.mediaType {
                                switch mediaType {
                                case .movie:
                                    if let runtime = movieModel.movie.runtime {
                                        Text("Runtime : \(movieModel.convertRuntimeInHour(runtime: runtime))")
                                            .font(.subheadline.italic())
                                            .foregroundStyle(Color.white)
                                    } else {
                                        Text("Runtime : N/A")
                                            .font(.subheadline.italic())
                                            .foregroundStyle(Color.white)
                                    }
                                case .tv:
                                    if let nbOfSeasons = tvModel.tvShow.number_of_seasons {
                                        Text("Number of seasons : \(nbOfSeasons)")
                                            .font(.subheadline.italic())
                                            .foregroundStyle(Color.white)
                                    }else if let nbOfEpisodes = tvModel.tvShow.number_of_episodes {
                                        Text("Number of episodes : \(nbOfEpisodes)")
                                            .font(.subheadline.italic())
                                            .foregroundStyle(Color.white)
                                    }
                                }
                            } else {
                                    
                            }
                            
                        }
                        if let mediaType = media.mediaType {
                            switch mediaType {
                                
                            case .movie :
                                if (!movieModel.movie.overview.isEmpty) {
                                    Text("Overview: \n\n\(movieModel.movie.overview)")
                                        .font(.callout)
                                        .foregroundStyle(Color.white)
                                        .padding(.top,20)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.center)
                                }else {
                                    Text("Overview: \n\nN/A")
                                        .font(.callout)
                                        .foregroundStyle(Color.white)
                                        .padding(.top,20)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.center)
                                }
                            case .tv :
                                if (!tvModel.tvShow.overview.isEmpty) {
                                    Text("Overview: \n\n\(tvModel.tvShow.overview)")
                                        .font(.callout)
                                        .foregroundStyle(Color.white)
                                        .padding(.top,20)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.center)
                                }else {
                                    Text("Overview: \n\nN/A")
                                        .font(.callout)
                                        .foregroundStyle(Color.white)
                                        .padding(.top,20)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                        HStack {
                            if let mediaType = media.mediaType {
                                switch mediaType {
                                    case .movie:
                                    if let hasCollection = movieModel.movie.hasCollection, hasCollection {
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "collection")
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: geometry.size.width * 0.2,height: 45)
                                                .foregroundColor(Color.clear)
                                                .overlay(
                                                    Text("Collection")
                                                        .font(.subheadline.italic())
                                                        .foregroundColor(Color.white)
                                                        .fontWeight(collectionBtn ? .bold : .regular)
                                                        .underline(collectionBtn)
                                                )
                                                .shadow(radius: 10)
                                                .padding(.trailing,30)
                                            }
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "details")
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width:geometry.size.width * 0.2,height: 45)
                                                .foregroundColor(Color.clear)
                                                .overlay(
                                                    Text("Details")
                                                        .font(.subheadline.italic())
                                                        .foregroundColor(Color.white)
                                                        .fontWeight(detailsBtn ? .bold : .regular)
                                                        .underline(detailsBtn)
                                                )
                                                .shadow(radius: 10)
                                                .padding(.top,10)
                                            }
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "production")
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: geometry.size.width * 0.2,height: 45)
                                                .foregroundColor(Color.clear)
                                                .overlay(
                                                    Text("Production")
                                                        .font(.subheadline.italic())
                                                        .foregroundColor(Color.white)
                                                )
                                                .shadow(radius: 10)
                                                .padding(.top,10)
                                                .padding(.leading,30)
                                            }
                                    }else {
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "details")
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width:geometry.size.width * 0.2,height: 45)
                                                .foregroundColor(Color.clear)
                                                .overlay(
                                                    Text("Details")
                                                        .font(.subheadline.italic())
                                                        .foregroundColor(Color.white)
                                                        .fontWeight(detailsBtn ? .bold : .regular)
                                                        .underline(detailsBtn)
                                                )
                                                .shadow(radius: 10)
                                                .padding(.top,10)
                                            }
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "production")
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: geometry.size.width * 0.2,height: 45)
                                                .foregroundColor(Color.clear)
                                                .overlay(
                                                    Text("Production")
                                                        .font(.subheadline.italic())
                                                        .foregroundColor(Color.white)
                                                        .fontWeight(productionBtn ? .bold : .regular)
                                                        .underline(productionBtn)
                                                )
                                                .shadow(radius: 10)
                                                .padding(.top,10)
                                                .padding(.leading,30)
                                            }
                                    }
                                    case .tv:
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "seasons")
                                        }) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: geometry.size.width * 0.2,height: 45)
                                            .foregroundColor(Color.clear)
                                            .overlay(
                                                Text("Seasons")
                                                    .font(.subheadline.italic())
                                                    .foregroundColor(Color.white)
                                                    .fontWeight(seasonsBtn ? .bold : .regular)
                                                    .underline(seasonsBtn)
                                            )
                                            .shadow(radius: 10)
                                            .padding(.top,10)
                                            .padding(.leading,30)
                                        }
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "details")
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width:geometry.size.width * 0.2,height: 45)
                                                .foregroundColor(Color.clear)
                                                .overlay(
                                                    Text("Details")
                                                        .font(.subheadline.italic())
                                                        .foregroundColor(Color.white)
                                                        .fontWeight(detailsBtn ? .bold : .regular)
                                                        .underline(detailsBtn)
                                                )
                                                .padding(.top,10)
                                                .shadow(radius: 10)
                                            }
                                        Button(action: {
                                            updateButtonsStates(selectedButton: "production")
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: geometry.size.width * 0.2,height: 45)
                                                .foregroundColor(Color.clear)
                                                .overlay(
                                                    Text("Production")
                                                        .font(.subheadline.italic())
                                                        .foregroundColor(Color.white)
                                                        .fontWeight(productionBtn ? .bold : .regular)
                                                        .underline(productionBtn)
                                                )
                                                .shadow(radius: 10)
                                                .padding(.top,10)
                                                .padding(.leading,30)
                                            }
                                }
                            }
                        }
                        
                        if (collectionBtn) {
                            
                        }else if (detailsBtn) {
                            if let mediaType = media.mediaType {
                                switch mediaType {
                                    case .movie:
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Slogan :")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                                if let slogan = movieModel.movie.tagline, !slogan.isEmpty {
                                                    Text("\"\(slogan)\"")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                            }
                                            .padding(.bottom,30)
                                            
                                            HStack {
                                                Text("Status :")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                                if let status = movieModel.movie.status, !status.isEmpty {
                                                    Text("\"\(status)\"")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                            }
                                            .padding(.bottom,30)
                                            
                                            HStack {
                                                let formattedVoteAverage = String(format: "Vote average : %.2f", movieModel.movie.voteAverage)
                                                Text("\(formattedVoteAverage)/10")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                                    .padding(.trailing,10)
                                                Text("Votes : \(movieModel.movie.voteCount)")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                            }
                                            .padding(.bottom,30)
                                            
                                            HStack {
                                                if let budget = movieModel.movie.budget, budget != 0 {
                                                    Text("Budget: \(budget) $")
                                                        .font(.callout.bold())
                                                        .foregroundStyle(Color.white)
                                                        .padding(.trailing,10)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                                if let revenue = movieModel.movie.revenue, revenue != 0 {
                                                    Text("Budget: \(revenue) $")
                                                        .font(.callout.bold())
                                                        .foregroundStyle(Color.white)
                                                        .padding(.trailing,10)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                                
                                            }
                                        }
                                    case.tv:
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Slogan :")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                                if let slogan = tvModel.tvShow.tagline, !slogan.isEmpty {
                                                    Text("\"\(slogan)\"")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                            }
                                            .padding(.bottom,30)
                                            
                                            HStack {
                                                Text("Status :")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                                if let status = tvModel.tvShow.status, !status.isEmpty {
                                                    Text("\"\(status)\"")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                            }
                                            .padding(.bottom,30)
                                            
                                            HStack {
                                                let formattedVoteAverage = String(format: "Vote average : %.2f", tvModel.tvShow.voteAverage)
                                                Text("\(formattedVoteAverage)/10")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                                    .padding(.trailing,10)
                                                Text("Votes : \(tvModel.tvShow.voteCount)")
                                                    .font(.callout.bold())
                                                    .foregroundStyle(Color.white)
                                            }
                                            .padding(.bottom,30)
                                            
                                            HStack {
                                                if let nbrOfSeasons = tvModel.tvShow.number_of_seasons, nbrOfSeasons != 0 {
                                                    Text("Number of seasons: \(nbrOfSeasons)")
                                                        .font(.callout.bold())
                                                        .foregroundStyle(Color.white)
                                                        .padding(.trailing,10)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                                if let nbOfEpisodes = tvModel.tvShow.number_of_episodes, nbOfEpisodes != 0 {
                                                    Text("Number of Episodes: \(nbOfEpisodes)")
                                                        .font(.callout.bold())
                                                        .foregroundStyle(Color.white)
                                                        .padding(.trailing,10)
                                                }else {
                                                    Text("N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                                
                                            }
                                        }
                                }
                            }
                                    
                            
                            
                        }else if (productionBtn) {
                            if let mediaType = media.mediaType {
                                switch mediaType {
                                case .movie:
                                    VStack {
                                        if let productionCompanies = movieModel.movie.productionCompanies {
                                                VStack {
                                                    if let imageData = logoModel.data, let uiImage = UIImage(data: imageData) {
                                                        Image(uiImage: uiImage)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.1)
                                                            .padding(.bottom, 30)
                                                            .padding(.top, 50)
                                                    } else {
                                                        Image(systemName: "questionmark.circle")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: geometry.size.width, height: 100)
                                                            .padding(.bottom, 30)
                                                            .padding(.top, 50)
                                                            .onAppear {
                                                                if let logo = productionCompanies.first?.logoPath, !logo.isEmpty {
                                                                    logoModel.fetchNormalImage(imgPath: logo)
                                                                }
                                                            }
                                                    }
                                                    Text("Name : \(productionCompanies.first?.name ?? "N/A")")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                        .padding(.bottom, 30)
                                                        
                                                    Text("Origin Country : \(productionCompanies.first?.originCountry ?? "N/A")")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                        .padding(.bottom, 30)
                                                    
                                                    Text("Director")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                        .padding(.bottom, 10)
                                                        
                                                    if let imageData = directorModel.data, let uiImage = UIImage(data: imageData) {
                                                        Image(uiImage: uiImage)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2)
                                                            .padding(.bottom, 10)
                                                            .padding(.top, 10)
                                                    } else {
                                                        Image(systemName: "questionmark.circle")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: geometry.size.width, height: 100)
                                                            .padding(.bottom, 10)
                                                            .padding(.top, 50)
                                                            .onAppear {
                                                                if let director = movieModel.getDirector(Crew: movieModel.movie.credits?.crew ?? []) {
                                                                    print(director)
                                                                    directorModel.fetchNormalImage(imgPath: director.profilePath ?? "")
                                                                }else {
                                                                    directorModel.fetchNormalImage(imgPath: movieModel.movie.credits?.crew?.first?.profilePath ?? "")
                                                                }
                                                            }
                                                        }
                                                    if let director = movieModel.getDirector(Crew: movieModel.movie.credits?.crew ?? []) {
                                                        Text(director.name)
                                                            .font(.callout)
                                                            .foregroundStyle(Color.white)
                                                            .padding(.bottom, 20)
                                                    }else {
                                                        Text(movieModel.movie.credits?.crew?.first?.name ?? "N/A")
                                                            .font(.callout)
                                                            .foregroundStyle(Color.white)
                                                            .padding(.bottom, 20)
                                                    }
                                                    Text("Cast")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                        .padding(.bottom, 20)
                                                    
                                                    if let credits = movieModel.movie.credits {
                                                        VStack(alignment: .leading, spacing: 16) {
                                                            ForEach(credits.cast ?? []) { cast in
                                                                HStack {
                                                                    MediaCardView(media: movieModel.movie, isHuman: true, humanPath: cast.profilePath)
                                                                        .padding(.leading,10)
                                                                    VStack(alignment: .leading, spacing: 5) {
                                                                        Text(cast.name)
                                                                            .font(.callout)
                                                                            .foregroundColor(Color.white)
                                                                        
                                                                        Text(cast.character ?? "N/A")
                                                                            .font(.callout)
                                                                            .foregroundColor(Color.white)
                                                                    }
                                                                    .padding(.bottom, 10)
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                }
                                            } else {
                                                Text("No production found")
                                                    .font(.callout)
                                                    .foregroundStyle(Color.white)
                                                Text("Director")
                                                    .font(.callout)
                                                    .foregroundStyle(Color.white)
                                                    .padding(.bottom, 10)
                                                    
                                                if let imageData = directorModel.data, let uiImage = UIImage(data: imageData) {
                                                    Image(uiImage: uiImage)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2)
                                                        .padding(.bottom, 10)
                                                        .padding(.top, 10)
                                                } else {
                                                    Image(systemName: "questionmark.circle")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: geometry.size.width, height: 100)
                                                        .padding(.bottom, 10)
                                                        .padding(.top, 50)
                                                        .onAppear {
                                                            if let director = movieModel.getDirector(Crew: movieModel.movie.credits?.crew ?? []) {
                                                                print(director)
                                                                directorModel.fetchNormalImage(imgPath: director.profilePath ?? "")
                                                            }else {
                                                                directorModel.fetchNormalImage(imgPath: movieModel.movie.credits?.crew?.first?.profilePath ?? "")
                                                            }
                                                        }
                                                    }
                                                if let director = movieModel.getDirector(Crew: movieModel.movie.credits?.crew ?? []) {
                                                    Text(director.name)
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                        .padding(.bottom, 20)
                                                }else {
                                                    Text(movieModel.movie.credits?.crew?.first?.name ?? "N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                        .padding(.bottom, 20)
                                                }
                                                Text("Cast")
                                                    .font(.callout)
                                                    .foregroundStyle(Color.white)
                                                    .padding(.bottom, 20)
                                                
                                                if let credits = movieModel.movie.credits {
                                                    VStack(alignment: .leading, spacing: 16) {
                                                        ForEach(credits.cast ?? []) { cast in
                                                            HStack {
                                                                MediaCardView(media: movieModel.movie, isHuman: true, humanPath: cast.profilePath)
                                                                    .padding(.leading,10)
                                                                VStack(alignment: .leading, spacing: 5) {
                                                                    Text(cast.name)
                                                                        .font(.callout)
                                                                        .foregroundColor(Color.white)
                                                                    
                                                                    Text(cast.character ?? "N/A")
                                                                        .font(.callout)
                                                                        .foregroundColor(Color.white)
                                                                }
                                                                .padding(.bottom, 10)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        
                                    }
                                case .tv:
                                    Text("")
                                }
                            }
                            
                        }else { //seasons
                            
                        }
                    }
                }
                .frame(height: geometry.size.height)
            }
            .edgesIgnoringSafeArea(.top)
            .background(
                LinearGradient(colors: [Color.gray.opacity(0.3),Color.black], startPoint: UnitPoint.top, endPoint: .bottom)
            )
            .onAppear {
                genreModel.getGenresForMedia(genresIds: movieModel.movie.genreIDS ?? [1])
                print("media genres : \(genreModel.mediaGenres)")
                if let hasCollection = movieModel.movie.hasCollection , hasCollection {
                    movieModel.fetchMovieCollectionById(collectionId: movieModel.movie.belongsToCollection?.id ?? 0)
                }
            }
        }
        .onAppear {
            if let path = media.backdropPath, !path.isEmpty {
                imageModel.fetchNormalImage(imgPath: path)
            }else {
                imageModel.fetchNormalImage(imgPath: media.posterPath)
            }
            
            genreModel.getGenresForMedia(genresIds: media.genreIDS ?? [1])
            print("media genres : \(genreModel.mediaGenres)")
            if let mediaType = media.mediaType {
                switch mediaType {
                case .movie:
                    movieModel.fetchMovieDetailsById(movieId: media.id as! Int)
                case .tv:
                    tvModel.fetchTvDetailsById(tvId: media.id as! Int)
                }
            }
        }
    }
}
#Preview {
    MediaDetailsView(media: Movie(
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
            crew: [
                Cast(
                        adult: false,
                        gender: 2,
                        id: 1,
                        knownForDepartment: Department(rawValue: "directing" ),
                        name: "George Lucas",
                        originalName: "George Lucas",
                        popularity: 14.496,
                        profilePath: "/WCSZzWdtPmdRxH9LUCVi2JPCSJ.jpg",
                        castID: 78,
                        character: nil,
                        creditID: "52fe431fc3a36847f803bea3",
                        order: nil,
                        job: "Screenplay"
                        
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 1,
                        knownForDepartment: Department(rawValue: "directing" ),
                        name: "George Lucas",
                        originalName: "George Lucas",
                        popularity: 14.496,
                        profilePath: "/WCSZzWdtPmdRxH9LUCVi2JPCSJ.jpg",
                        castID: 78,
                        character: nil,
                        creditID: "52fe431fc3a36847f803be97",
                        order: nil,
                        job: "Director"
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 1,
                        knownForDepartment: Department(rawValue: "directing" ),
                        name: "George Lucas",
                        originalName: "George Lucas",
                        popularity: 14.496,
                        profilePath: "/WCSZzWdtPmdRxH9LUCVi2JPCSJ.jpg",
                        castID: nil,
                        character: nil,
                        creditID: "52fe431fc3a36847f803bec1",
                        order: nil,
                        job: "Executive Producer"
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 19801,
                        knownForDepartment: Department(rawValue: "production" ),
                        name: "Rick McCallum",
                        originalName: "Rick McCallum",
                        popularity: 2.176,
                        profilePath: "/moMu1b9MzEbpJ4dnz4zfKPkgRxE.jpg",
                        castID: nil,
                        character: nil,
                        creditID: "52fe431fc3a36847f803be9d",
                        order: nil,
                        job: "Producer"
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 491,
                        knownForDepartment: Department(rawValue: "sound" ),
                        name: "John Williams",
                        originalName: "John Williams",
                        popularity: 5.773,
                        profilePath: "/KFyMqUWeiBdP9tJcZyGWOqnrgK.jpg",
                        castID: nil,
                        character: nil,
                        creditID: "52fe431fc3a36847f803bec7",
                        order: nil,
                        job: "Original Music Composer"
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 670,
                        knownForDepartment: Department(rawValue: "sound" ),
                        name: "Ben Burtt",
                        originalName: "Ben Burtt",
                        popularity: 7.231,
                        profilePath: "/16OhOb7WngOi4WOnGpRpbDSzYnd.jpg",
                        castID: nil,
                        character: nil,
                        creditID: "52fe431fc3a36847f803beb5",
                        order: nil,
                        job: "Editor"
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 670,
                        knownForDepartment: Department(rawValue: "Sound"),
                        name: "Ben Burtt",
                        originalName: "Ben Burtt",
                        popularity: 7.231,
                        profilePath: "/16OhOb7WngOi4WOnGpRpbDSzYnd.jpg",
                        castID: nil,
                        character: nil,
                        creditID: "5aa9c38d9251410564003085",
                        order: nil,
                        job: "Sound Designer"
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 670,
                        knownForDepartment: Department(rawValue: "sound"),
                        name: "Ben Burtt",
                        originalName: "Ben Burtt",
                        popularity: 7.231,
                        profilePath: "/16OhOb7WngOi4WOnGpRpbDSzYnd.jpg",
                        castID: nil,
                        character: nil,
                        creditID: "62397e127a1bd6001ceeb32f",
                        order: nil,
                        job: "Supervising Sound Editor"
                    ),
                Cast(
                        adult: false,
                        gender: 2,
                        id: 6800,
                        knownForDepartment:Department(rawValue: "camera"),
                        name: "David Tattersall",
                        originalName: "David Tattersall",
                        popularity: 1.409,
                        profilePath: "/5Gnvt1M0of6qN1NMoVHvROz86QG.jpg",
                        castID: nil,
                        character: nil,
                        creditID: "5f9647a838e5100039ddc8c6",
                        order: nil,
                        job: "Director of Photography"
                    )
            ]
        ),
        hasCollection: false
    ))
}

/*
 Movie(
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
     tagline: nil,
    hasCollection: false
 )
 
 TVShow(
 title: "Untitled Show",
 name: "Unnamed Show",
 adult: false,
 backdropPath: "/defaultBackdropPath.jpg",
 id: 1,
 originalLanguage: .en,
 originalName: "Untitled Original Name",
 overview: "No overview available.",
 posterPath: "/defaultPosterPath.jpg",
 mediaType: .tv,
 genreIDS: [0],
 popularity: 0.0,
 firstAirDate: "1970-01-01",
 voteAverage: 0.0,
 voteCount: 0,
 originCountry: [.US],
 runtime: 30,
 created_by: [CreatedBy(id: 1, credit_id: "defaultCreditID", name: "Default Creator", gender: 0, profile_path: "/defaultProfilePath.jpg")],
 episode_run_time: [30],
 genres: [Genre(id: 0, name: "Undefined Genre")],
 homepage: "https://example.com",
 in_production: true,
 languages: ["en"],
 last_air_date: "1970-01-01",
 last_episode_to_air: Episode(
 id: 1,
 name: "Default Episode",
 overview: "No overview available.",
 vote_average: 0.0,
 vote_count: 0,
 air_date: "1970-01-01",
 episode_number: 1,
 episode_type: "Undefined",
 production_code: "",
 runtime: 30,
 season_number: 1,
 show_id: 1,
 still_path: "/defaultEpisodeStillPath.jpg"
 ),
 next_episode_to_air: nil,
 networks: [Network(id: 1, logo_path: "/defaultLogoPath.jpg", name: "Default Network", origin_country: "US")],
 number_of_episodes: 1,
 number_of_seasons: 1,
 seasons: [Season(air_date: "1970-01-01", episode_count: 1, id: 1, name: "Default Season", overview: "No overview available.", poster_path: "/defaultSeasonPosterPath.jpg", season_number: 1, vote_average: 0.0)],
 spoken_languages: [SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")],
 status: "Unknown",
 tagline: "No tagline available.",
 type: "Unknown",
 vote_count: 0
 )
 */
