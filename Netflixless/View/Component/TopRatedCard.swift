//
//  TopRatedCard.swift
//  Netflixless
//
//  Created by Augustin Diabira on 02/02/2024.
//

import SwiftUI
import Kingfisher

struct TopRatedCard: View {
    let result: Result
    var body: some View {
        VStack {
            KFImage(URL(string: result.imageUrl + (result.posterPath ?? "")))
                .resizable()
                .frame(width: 180, height: 195)
               
        }
    }
}

#Preview {
    TopRatedCard(result: TopRated.topRate)
}
