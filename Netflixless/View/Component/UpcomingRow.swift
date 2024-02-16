//
//  UpcomingRow.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI
import NukeUI
import Nuke

struct UpcomingRow: View {
    let tmdb: TMDB
    private let pipeline = ImagePipeline {
        $0.dataCache = try? DataCache(name: "com.myapp.datacache")
        $0.dataCachePolicy = .storeOriginalData
    }
    var body: some View {
        NavigationLink {
            TMDBDetailView(show: tmdb)
        } label: {
            HStack(alignment: .top, spacing: 10) {
                LazyImage(url: URL(string: tmdb.imageUrl + (tmdb.posterPath ?? ""))){image in
                    if let image = image.image {
                        image
                            .resizable()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                    }else {
                        Image(.placeholder)
                            .resizable()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                    }
                   
                }
                .pipeline(pipeline)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(tmdb.name ?? tmdb.originalTitle ?? tmdb.originalName ?? "Unknown")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text("Release Date: \(tmdb.releaseDate ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
        }
        
    }
}
