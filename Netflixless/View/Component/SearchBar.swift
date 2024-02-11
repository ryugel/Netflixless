//
//  SearchBar.swift
//  Netflixless
//
//  Created by Augustin Diabira on 02/02/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var txt :String
    var body: some View {
        HStack(spacing: 15) {
                   Image(systemName: "magnifyingglass")
                       .font(.body)
                       .foregroundColor(.white)
                   
                   TextField("Search For Movies, Shows", text: $txt)
                .foregroundColor(.white.opacity(0.5))
               }
               .padding()
               .background(Color.clear.opacity(0.5))
    }
}

