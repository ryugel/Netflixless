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
    @StateObject private var seasonImageModel: ImageModel = ImageModel()
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
                                                    Text("Revenue: N/A")
                                                        .font(.callout)
                                                        .foregroundStyle(Color.white)
                                                }
                                                if let revenue = movieModel.movie.revenue, revenue != 0 {
                                                    Text("Budget: \(revenue) $")
                                                        .font(.callout.bold())
                                                        .foregroundStyle(Color.white)
                                                        .padding(.trailing,10)
                                                }else {
                                                    Text("Budget: N/A")
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
                                                
                                                Text("Votes : \(tvModel.tvShow.voteCount ?? 1000)")
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
                                                if let director = movieModel.getDirector(Crew: tvModel.tvShow.credits?.crew ?? []) {
                                                    print("Poulet")
                                                    directorModel.fetchNormalImage(imgPath: director.profilePath ?? "")
                                                }else {
                                                    directorModel.fetchNormalImage(imgPath: tvModel.tvShow.credits?.crew?.first?.profilePath ?? "")
                                                }
                                            }
                                        }
                                    if let director = movieModel.getDirector(Crew: tvModel.tvShow.credits?.crew ?? []) {
                                        Text(director.name)
                                            .font(.callout)
                                            .foregroundStyle(Color.white)
                                            .padding(.bottom, 20)
                                    }else {
                                        Text(tvModel.tvShow.credits?.crew?.first?.name ?? "N/A")
                                            .font(.callout)
                                            .foregroundStyle(Color.white)
                                            .padding(.bottom, 20)
                                    }
                                    Text("Cast")
                                        .font(.callout)
                                        .foregroundStyle(Color.white)
                                        .padding(.bottom, 20)
                                    
                                    if let credits = tvModel.tvShow.credits {
                                        VStack(alignment: .leading, spacing: 16) {
                                            ForEach(credits.cast ?? []) { cast in
                                                HStack {
                                                    MediaCardView(media: tvModel.tvShow, isHuman: true, humanPath: cast.profilePath)
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
                            
                        }else { //seasons
                            if let seasons = tvModel.tvShow.seasons {
                                VStack {
                                    ForEach(seasons) { season in
                                        
                                        VStack {
                                            Text("Season number: \(season.season_number ?? 0)")
                                                .font(.callout)
                                                .foregroundColor(Color.white)
                                                .padding(.bottom,20)
                                                .padding(.top,20)
                                            Text("Air date: \(season.air_date ?? "N/A")")
                                                .font(.callout)
                                                .foregroundColor(Color.white)
                                            Text("Number of episodes: \(season.episode_count ?? 0)")
                                                .font(.callout)
                                                .foregroundColor(Color.white)
                                            Text("Vote average: \(season.vote_average ?? 0.0)")
                                                .font(.callout)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                }
                            }
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
    MediaDetailsView(media: TVShow(
        id: 108978,
        title: "Reacher",
        name: "Reacher",
        adult: false,
        backdropPath: "/m5CggjJuFc08QCuKz54znHP6spJ.jpg",
        originalLanguage: .en,
        originalName: "Reacher",
        overview: "Jack Reacher, a veteran military police investigator, has just recently entered civilian life...",
        posterPath: "/jFuH0md41x5mB4qj5344mSmtHrO.jpg",
        mediaType: .tv,
        genreIDS: [10759, 80, 18],
        popularity: 496.204,
        firstAirDate: "2022-02-03",
        voteAverage: 8.115,
        voteCount: 1397,
        originCountry: [.US],
        runtime: nil,
        created_by: [
            CreatedBy(id: 78417, credit_id: "5f54f833713ed40036eed3e7", name: "Nick Santora", gender: 2, profile_path: "/iipP9fTQhRuPJHFMhbpMCceBiiu.jpg")
        ],
        episode_run_time: [],
        genres: [
            Genre(id: 10759, name: "Action & Adventure"),
            Genre(id: 80, name: "Crime"),
            Genre(id: 18, name: "Drama")
        ],
        homepage: "https://www.amazon.com/dp/B09ML1ZF3D",
        in_production: true,
        languages: ["en"],
        last_air_date: "2024-01-18",
        last_episode_to_air: Episode(
            id: 4901216,
            name: "Fly Boy",
            overview: "Reacher and Neagley make a final desperate attempt to save O’Donnell and Dixon, stop A.M. and avenge their friends’ murder.",
            vote_average: 7.2,
            vote_count: 13,
            air_date: "2024-01-18",
            episode_number: 8,
            episode_type: "finale",
            production_code: "",
            runtime: 42,
            season_number: 2,
            show_id: 108978,
            still_path: "/7Jt8ghfYb2jx7hg1H5UbEUEH101.jpg"
        ),
        next_episode_to_air: nil,
        networks: [
            Network(id: 1024, logo_path: "/ifhbNuuVnlwYy5oXA5VIb2YR8AZ.png", name: "Prime Video", origin_country: "")
        ],
        number_of_episodes: 16,
        number_of_seasons: 2,
        seasons: [
            Season(
                air_date: "2022-02-03",
                episode_count: 8,
                id: 161571,
                name: "Season 1",
                overview: "Based on \"Killing Floor,\" when retired Military Police Officer Jack Reacher is arrested for a murder he did not commit, he finds himself in the middle of a deadly conspiracy full of dirty cops, shady businessmen and scheming politicians. With nothing but his wits, he must figure out what is happening in Margrave, Georgia.",
                poster_path: "/bQnnKBe3VsvXKMoNCaYmRzs1Dup.jpg",
                season_number: 1,
                vote_average: 7.4
            ),
            Season(
                air_date: "2023-12-14",
                episode_count: 8,
                id: 364732,
                name: "Season 2",
                overview: "Based on\"Bad Luck and Trouble,\" when members of Reacher's old military unit start turning up dead, Reacher has just one thing on his mind—revenge.",
                poster_path: "/oVw8KUQn1RSDd8KmknpvIc34JtY.jpg",
                season_number: 2,
                vote_average: 7.1
            )
        ],
        spoken_languages: [
            SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")
        ],
        status: "Returning Series",
        tagline: "Reacher's back.",
        type: "Scripted",
        credits: Credits(
            cast: [
                Cast(adult: false, gender: 2, id: 64295, knownForDepartment: Department(rawValue: "Acting"), name: "Alan Ritchson", originalName: "Alan Ritchson", popularity: 62.276, profilePath: "/wdmLUSPEC7dXuqnjTM4NgbjvTKk.jpg",castID: nil, character: "Jack Reacher", creditID: "5f54f95984f2490035f8e399", order: 0,job: nil),
                Cast(adult: false, gender: 1, id: 2123496, knownForDepartment: Department(rawValue: "Acting"), name: "Maria Sten", originalName: "Maria Sten", popularity: 24.896, profilePath: "/7QlPWbZRH2ORMmAHKAj0rq54t4A.jpg",castID: nil, character: "Frances Neagley", creditID: "61a969cb9a64350044e918ba", order: 2,job: nil),
                Cast(adult: false, gender: 1, id: 86268, knownForDepartment: Department(rawValue: "Acting"), name: "Serinda Swan", originalName: "Serinda Swan", popularity: 43.039, profilePath: "/mA4qtNZnn0A2oT1s4IIHseO8oiu.jpg",castID: nil, character: "Karla Dixon", creditID: "657c0646ec8a4300aa6e1522", order: 4,job: nil),
                Cast(adult: false, gender: 2, id: 65772, knownForDepartment: Department(rawValue: "Acting"), name: "Shaun Sipos", originalName: "Shaun Sipos", popularity: 11.548, profilePath: "/vXsKlHCCwwipQJoklvJisSVj6Fc.jpg",castID: nil, character: "David O'Donnell", creditID: "657c05cf8e2ba600c4f16f3f", order: 6,job: nil),
                Cast(adult: false, gender: 2, id: 1211873, knownForDepartment: Department(rawValue: "Acting"), name: "Ferdinand Kingsley", originalName: "Ferdinand Kingsley", popularity: 6.626, profilePath: "/arGWhGhfBl8CvNuUoKkUmfrDG0b.jpg",castID: nil, character: "A.M.", creditID: "657c401c7ecd280101d386c7", order: 8,job: nil),
                Cast(adult: false, gender: 2, id: 418, knownForDepartment: Department(rawValue: "Acting"), name: "Robert Patrick", originalName: "Robert Patrick", popularity: 27.562, profilePath: "/qRv2Es9rZoloullTbzss3I5j1Mp.jpg",castID: nil, character: "Shane Langston", creditID: "657c06af63e6fb011edd8e23", order: 9,job: nil)
            ],
            crew: [
                Cast(adult: false, gender: 2, id: 1703771, knownForDepartment: Department(rawValue: "Writing"), name: "Adam Higgs", originalName: "Adam Higgs", popularity: 3.839, profilePath: nil,castID: nil,character: nil, creditID: "657c468a7ecd28011ef2aed4",order: nil, job: "Executive Producer"),
                Cast(adult: false, gender: 0, id: 4431386, knownForDepartment: Department(rawValue: "Production"), name: "Matt Thunell", originalName: "Matt Thunell", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657c46d3564ec7011b21dccf",order: nil, job: "Executive Producer"),
                Cast(adult: false, gender: 1, id: 1611446, knownForDepartment: Department(rawValue: "Writing"), name: "Penny Cox", originalName: "Penny Cox", popularity: 1.757, profilePath: nil,castID: nil,character: nil, creditID: "657c470c8e2ba600e1fd41da",order: nil, job: "Producer"),
                Cast(adult: false, gender: 0, id: 1084756, knownForDepartment: Department(rawValue: "Art"), name: "Nazgol Goshtasbpour", originalName: "Nazgol Goshtasbpour", popularity: 1.955, profilePath: nil,castID: nil,character: nil, creditID: "657c472eea3949011b3cf89d",order: nil, job: "Production Design"),
                Cast(adult: false, gender: 0, id: 1525195, knownForDepartment: Department(rawValue: "Costume & Make-Up"), name: "Abram Waterhouse", originalName: "Abram Waterhouse", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657c473a564ec700acd67c95",order: nil, job: "Costume Design"),
                Cast(adult: false, gender: 0, id: 378260, knownForDepartment: Department(rawValue: "Production"), name: "Derek Rappaport", originalName: "Derek Rappaport", popularity: 3.791, profilePath: nil,castID: nil,character: nil, creditID: "657cae5addd52d011b69d105",order: nil, job: "Producer"),
                Cast(adult: false, gender: 0, id: 2414790, knownForDepartment: Department(rawValue: "Production"), name: "Lisa Kussner", originalName: "Lisa Kussner", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657cae937ecd28013b3f2efe",order: nil, job: "Consulting Producer"),
                Cast(adult: false, gender: 0, id: 4071653, knownForDepartment: Department(rawValue: "Directing"), name: "David Carruthers", originalName: "David Carruthers", popularity: 0.695, profilePath: nil,castID: nil,character: nil, creditID: "657caf0263e6fb0100c6dd39",order: nil, job: "Production Manager"),
                Cast(adult: false, gender: 0, id: 1772710, knownForDepartment: Department(rawValue: "Writing"), name: "Cait Duffy", originalName: "Cait Duffy", popularity: 1.715, profilePath: nil,castID: nil,character: nil, creditID: "657caf1b176a941730623b83",order: nil, job: "Story Editor"),
                Cast(adult: false, gender: 1, id: 4079766, knownForDepartment: Department(rawValue: "Writing"), name: "Lillian Wang", originalName: "Lillian Wang", popularity: 1.669, profilePath: nil,castID: nil,character: nil, creditID: "657cb13d176a941733d6c2ec",order: nil, job: "Staff Writer")
            ]
        )
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
     id: 108978,
     title: "Reacher",
     name: "Reacher",
     adult: false,
     backdropPath: "/m5CggjJuFc08QCuKz54znHP6spJ.jpg",
     originalLanguage: .en,
     originalName: "Reacher",
     overview: "Jack Reacher, a veteran military police investigator, has just recently entered civilian life...",
     posterPath: "/jFuH0md41x5mB4qj5344mSmtHrO.jpg",
     mediaType: nil,
     genreIDS: [10759, 80, 18],
     popularity: 496.204,
     firstAirDate: "2022-02-03",
     voteAverage: 8.115,
     voteCount: 1397,
     originCountry: [.US],
     runtime: nil,
     created_by: [
         CreatedBy(id: 78417, credit_id: "5f54f833713ed40036eed3e7", name: "Nick Santora", gender: 2, profile_path: "/iipP9fTQhRuPJHFMhbpMCceBiiu.jpg")
     ],
     episode_run_time: [],
     genres: [
         Genre(id: 10759, name: "Action & Adventure"),
         Genre(id: 80, name: "Crime"),
         Genre(id: 18, name: "Drama")
     ],
     homepage: "https://www.amazon.com/dp/B09ML1ZF3D",
     in_production: true,
     languages: ["en"],
     last_air_date: "2024-01-18",
     last_episode_to_air: Episode(
         id: 4901216,
         name: "Fly Boy",
         overview: "Reacher and Neagley make a final desperate attempt to save O’Donnell and Dixon, stop A.M. and avenge their friends’ murder.",
         vote_average: 7.2,
         vote_count: 13,
         air_date: "2024-01-18",
         episode_number: 8,
         episode_type: "finale",
         production_code: "",
         runtime: 42,
         season_number: 2,
         show_id: 108978,
         still_path: "/7Jt8ghfYb2jx7hg1H5UbEUEH101.jpg"
     ),
     next_episode_to_air: nil,
     networks: [
         Network(id: 1024, logo_path: "/ifhbNuuVnlwYy5oXA5VIb2YR8AZ.png", name: "Prime Video", origin_country: "")
     ],
     number_of_episodes: 16,
     number_of_seasons: 2,
     seasons: [
         Season(
             air_date: "2022-02-03",
             episode_count: 8,
             id: 161571,
             name: "Season 1",
             overview: "Based on \"Killing Floor,\" when retired Military Police Officer Jack Reacher is arrested for a murder he did not commit, he finds himself in the middle of a deadly conspiracy full of dirty cops, shady businessmen and scheming politicians. With nothing but his wits, he must figure out what is happening in Margrave, Georgia.",
             poster_path: "/bQnnKBe3VsvXKMoNCaYmRzs1Dup.jpg",
             season_number: 1,
             vote_average: 7.4
         ),
         Season(
             air_date: "2023-12-14",
             episode_count: 8,
             id: 364732,
             name: "Season 2",
             overview: "Based on\"Bad Luck and Trouble,\" when members of Reacher's old military unit start turning up dead, Reacher has just one thing on his mind—revenge.",
             poster_path: "/oVw8KUQn1RSDd8KmknpvIc34JtY.jpg",
             season_number: 2,
             vote_average: 7.1
         )
     ],
     spoken_languages: [
         SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")
     ],
     status: "Returning Series",
     tagline: "Reacher's back.",
     type: "Scripted",
     credits: Credits(
         cast: [
             Cast(adult: false, gender: 2, id: 64295, knownForDepartment: Department(rawValue: "Acting"), name: "Alan Ritchson", originalName: "Alan Ritchson", popularity: 62.276, profilePath: "/wdmLUSPEC7dXuqnjTM4NgbjvTKk.jpg",castID: nil, character: "Jack Reacher", creditID: "5f54f95984f2490035f8e399", order: 0,job: nil),
             Cast(adult: false, gender: 1, id: 2123496, knownForDepartment: Department(rawValue: "Acting"), name: "Maria Sten", originalName: "Maria Sten", popularity: 24.896, profilePath: "/7QlPWbZRH2ORMmAHKAj0rq54t4A.jpg",castID: nil, character: "Frances Neagley", creditID: "61a969cb9a64350044e918ba", order: 2,job: nil),
             Cast(adult: false, gender: 1, id: 86268, knownForDepartment: Department(rawValue: "Acting"), name: "Serinda Swan", originalName: "Serinda Swan", popularity: 43.039, profilePath: "/mA4qtNZnn0A2oT1s4IIHseO8oiu.jpg",castID: nil, character: "Karla Dixon", creditID: "657c0646ec8a4300aa6e1522", order: 4,job: nil),
             Cast(adult: false, gender: 2, id: 65772, knownForDepartment: Department(rawValue: "Acting"), name: "Shaun Sipos", originalName: "Shaun Sipos", popularity: 11.548, profilePath: "/vXsKlHCCwwipQJoklvJisSVj6Fc.jpg",castID: nil, character: "David O'Donnell", creditID: "657c05cf8e2ba600c4f16f3f", order: 6,job: nil),
             Cast(adult: false, gender: 2, id: 1211873, knownForDepartment: Department(rawValue: "Acting"), name: "Ferdinand Kingsley", originalName: "Ferdinand Kingsley", popularity: 6.626, profilePath: "/arGWhGhfBl8CvNuUoKkUmfrDG0b.jpg",castID: nil, character: "A.M.", creditID: "657c401c7ecd280101d386c7", order: 8,job: nil),
             Cast(adult: false, gender: 2, id: 418, knownForDepartment: Department(rawValue: "Acting"), name: "Robert Patrick", originalName: "Robert Patrick", popularity: 27.562, profilePath: "/qRv2Es9rZoloullTbzss3I5j1Mp.jpg",castID: nil, character: "Shane Langston", creditID: "657c06af63e6fb011edd8e23", order: 9,job: nil)
         ],
         crew: [
             Cast(adult: false, gender: 2, id: 1703771, knownForDepartment: Department(rawValue: "Writing"), name: "Adam Higgs", originalName: "Adam Higgs", popularity: 3.839, profilePath: nil,castID: nil,character: nil, creditID: "657c468a7ecd28011ef2aed4",order: nil, job: "Executive Producer"),
             Cast(adult: false, gender: 0, id: 4431386, knownForDepartment: Department(rawValue: "Production"), name: "Matt Thunell", originalName: "Matt Thunell", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657c46d3564ec7011b21dccf",order: nil, job: "Executive Producer"),
             Cast(adult: false, gender: 1, id: 1611446, knownForDepartment: Department(rawValue: "Writing"), name: "Penny Cox", originalName: "Penny Cox", popularity: 1.757, profilePath: nil,castID: nil,character: nil, creditID: "657c470c8e2ba600e1fd41da",order: nil, job: "Producer"),
             Cast(adult: false, gender: 0, id: 1084756, knownForDepartment: Department(rawValue: "Art"), name: "Nazgol Goshtasbpour", originalName: "Nazgol Goshtasbpour", popularity: 1.955, profilePath: nil,castID: nil,character: nil, creditID: "657c472eea3949011b3cf89d",order: nil, job: "Production Design"),
             Cast(adult: false, gender: 0, id: 1525195, knownForDepartment: Department(rawValue: "Costume & Make-Up"), name: "Abram Waterhouse", originalName: "Abram Waterhouse", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657c473a564ec700acd67c95",order: nil, job: "Costume Design"),
             Cast(adult: false, gender: 0, id: 378260, knownForDepartment: Department(rawValue: "Production"), name: "Derek Rappaport", originalName: "Derek Rappaport", popularity: 3.791, profilePath: nil,castID: nil,character: nil, creditID: "657cae5addd52d011b69d105",order: nil, job: "Producer"),
             Cast(adult: false, gender: 0, id: 2414790, knownForDepartment: Department(rawValue: "Production"), name: "Lisa Kussner", originalName: "Lisa Kussner", popularity: 0.6, profilePath: nil,castID: nil,character: nil, creditID: "657cae937ecd28013b3f2efe",order: nil, job: "Consulting Producer"),
             Cast(adult: false, gender: 0, id: 4071653, knownForDepartment: Department(rawValue: "Directing"), name: "David Carruthers", originalName: "David Carruthers", popularity: 0.695, profilePath: nil,castID: nil,character: nil, creditID: "657caf0263e6fb0100c6dd39",order: nil, job: "Production Manager"),
             Cast(adult: false, gender: 0, id: 1772710, knownForDepartment: Department(rawValue: "Writing"), name: "Cait Duffy", originalName: "Cait Duffy", popularity: 1.715, profilePath: nil,castID: nil,character: nil, creditID: "657caf1b176a941730623b83",order: nil, job: "Story Editor"),
             Cast(adult: false, gender: 1, id: 4079766, knownForDepartment: Department(rawValue: "Writing"), name: "Lillian Wang", originalName: "Lillian Wang", popularity: 1.669, profilePath: nil,castID: nil,character: nil, creditID: "657cb13d176a941733d6c2ec",order: nil, job: "Staff Writer")
         ]
     )
 )
 */
