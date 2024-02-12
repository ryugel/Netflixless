//
//  NetflixlessApp.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import SwiftUI
import Firebase

@main
struct NetflixlessApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.dark)
        }
    }
}
