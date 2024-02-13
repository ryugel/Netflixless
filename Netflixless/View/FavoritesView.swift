//
//  FavoritesView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 11/02/2024.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        VStack {
            ContentUnavailableView("No Favorites", systemImage: "heart.slash", description: Text("You have no favorites shows or movies yet. Feel free to add some."))
        }

    }
}

#Preview {
    FavoritesView()
}
