//
//  MainView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 12/02/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MainView: View {
    @State var myProfile:User?
    @AppStorage("is_logged") var isLogged = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
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
