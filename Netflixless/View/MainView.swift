//
//  MainView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 12/02/2024.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("is_logged") var isLogged = false
    var body: some View {
        if isLogged {
            HomeView()
        }else {
            ContentView()
        }
    }
}

#Preview {
    MainView()
}
