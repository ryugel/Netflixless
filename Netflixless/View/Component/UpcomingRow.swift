//
//  UpcomingRow.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI
import Kingfisher

struct UpcomingRow: View {
    let tmdb: TMDB
    
    var body: some View {
        NavigationLink {
            TMDBDetailView(show: tmdb)
        } label: {
            HStack(alignment: .top, spacing: 10) {
                KFImage(URL(string: tmdb.imageUrl + (tmdb.posterPath ?? "")))
                    .resizable()
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
                
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
