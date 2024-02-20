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
    
    @StateObject private var vm = TMDBViewModel()
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if isLogged {
            HomeView()
                .environmentObject(vm)
        }else {
            ContentView()
        }
    }
}

#Preview {
    MainView()
}
