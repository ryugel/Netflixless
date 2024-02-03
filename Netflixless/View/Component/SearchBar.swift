//
//  SearchBar.swift
//  Netflixless
//
//  Created by Augustin Diabira on 02/02/2024.
//

import SwiftUI

struct SearchBar: View {
    @State var txt = ""
    var body: some View {
        HStack(spacing: 15){
            
            Image(systemName: "magnifyingglass")
                .font(.body)
                .foregroundColor(.white)
            
            TextField("Search For Movies,Shows", text: $txt)
            
        }.padding()
            .background(Color.gray)
        
    }
}

#Preview {
    SearchBar()
}
