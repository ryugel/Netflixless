//
//  ContentView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State var Through = "Through"
    var user = User.user
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(user.age)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
