//
//  PopularCard.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import SwiftUI
import Kingfisher

struct PopularCard: View {
    let show:Show
    var body: some View {
        VStack {
            KFImage(URL(string: show.imageUrl + (show.posterPath ?? "")))
                .resizable()
                .frame(width: 80, height: 95)
        }
    }
}

#Preview {
    PopularCard(show: Popular.popularShow)
}
