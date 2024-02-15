//
//  YoutubeView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import SwiftUI
import WebKit
import FirebaseAuth
import FirebaseFirestore

struct TMDBDetailView: View {
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var vm = YoutubeViewModel()
    var show: TMDB
    @State private var isFavorited = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .center, spacing: 10) {
                    ForEach(vm.trailers, id: \.id) { item in
                        TrailerView(videoID: item.id?.videoID ?? "")
                            .frame(height: 200)
                    }
                }
                
                HStack {
                    Text(show.overview ?? "")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.vertical)
                        .padding(.horizontal, 10)
                        .background(Color(.systemBackground).opacity(0.05))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Stars:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= Int(show.voteAverage / 2) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if isInFavorites {
                            userViewModel.removeFromFavorites(show)
                        } else {
                            userViewModel.addToFavorites(show)
                        }
                        isFavorited.toggle()
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(isFavorited ? .red : .gray) // Change color based on isInFavorites
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle((show.originalTitle ?? show.name) ?? "", displayMode: .inline)
        }
        .task {
            vm.fetchTrailer(query: "\(show.originalTitle ?? show.name ?? show.originalName ?? "") trailer")
            await userViewModel.fetchUser()
            isFavorited = isInFavorites
        }
    }
    private var isInFavorites: Bool {
        guard let user = userViewModel.user else { return false }
        return user.favorites.contains(show)
    }
    
}

struct TrailerView: View {
    let videoID: String
    
    var body: some View {
        WebView(urlString: "https://www.youtube.com/embed/\(videoID)")
    }
}


struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

