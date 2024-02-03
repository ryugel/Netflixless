//
//  TrendingsCard.swift
//  Netflixless
//
//  Created by Augustin Diabira on 02/02/2024.
//

import SwiftUI
import Kingfisher


struct TrendingsCard: View {
    let trend: Movie
    var body: some View {
        HStack {
            KFImage(URL(string: "\(trend.imageUrl)\(trend.posterPath)"))
                .resizable()
                .frame(width: 80, height: 95)
        }
    }
}

#Preview {
    TrendingsCard(trend: Trendings.trend)
}
