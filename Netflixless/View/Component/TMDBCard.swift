//
//  TMDBCard.swift
//  Netflixless
//
//  Created by Augustin Diabira on 10/02/2024.
//

import SwiftUI
import Kingfisher

struct TMDBCard: View {
    let tmdb: TMDB
    var body: some View {
        VStack {
            KFImage(URL(string: tmdb.imageUrl + (tmdb.posterPath ?? "")))
                .resizable()
                .frame(width: 80, height: 95)
        }
    }
}
