//
//  UpcomingCard.swift
//  Netflixless
//
//  Created by Augustin Diabira on 10/02/2024.
//

import SwiftUI
import Kingfisher

struct UpcomingCard: View {
    let upcomingShow: UpcomingShow
    var body: some View {
        VStack {
            KFImage(URL(string: upcomingShow.imageUrl + (upcomingShow.posterPath ?? "")))
                .resizable()
                .frame(width: 80, height: 95)
        }
    }
}

