//
//  YoutubeView.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import SwiftUI
import WebKit

struct YoutubeView: View {
    @StateObject var vm = YoutubeViewModel()
    let show: OnAir
    var body: some View {
        VStack {
            VStack {
                ForEach(vm.trailers, id: \.id) { item in
                    WebView(urlString: "https://www.youtube.com/embed/\(item.id?.videoID ?? "")")
                        .frame(height: 300)
                }
                Text(show.overview ?? "")
                Spacer()
                
            }.navigationTitle(show.name ?? "")
        } .onAppear(perform: {
            vm.fetchTrailer(query: "\(String(describing: show.name)) trailer")
    })
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
