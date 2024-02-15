//
//  ProfileView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 01/02/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.green
            Text("Profile")
                .foregroundColor(Color.white)
                .font(.bold(.largeTitle)())
        }
        .background(Color(#colorLiteral(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, alpha: 0.8470588235)))
    }
}

#Preview {
    ProfileView()
}
