//
//  TMDBCard.swift
//  Netflixless
//
//  Created by Augustin Diabira on 10/02/2024.
//

import SwiftUI
import NukeUI
import Nuke

struct TMDBCard: View {
    let tmdb: TMDB
    private let pipeline = ImagePipeline {
        $0.dataCache = try? DataCache(name: "com.myapp.datacache")
        $0.dataCachePolicy = .storeOriginalData
    }
    var body: some View {
        NavigationLink {
            TMDBDetailView(show: tmdb)
        } label: {
            VStack {
                LazyImage(url: URL(string: tmdb.imageUrl + (tmdb.posterPath ?? ""))){image in
                    
                    if let image = image.image {
                        image
                            .resizable()
                            .frame(width: 80, height: 95)
                    }else {
                        Image(.placeholder)
                            .resizable()
                            .frame(width: 80, height: 95)
                    }
                   
                }
                
                .processors([.resize(size: .init(width: 80, height: 95))])
                .priority(.veryHigh)
                .pipeline(pipeline)
            }
        }

    }
}
