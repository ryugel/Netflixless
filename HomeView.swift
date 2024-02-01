//
//  SwiftUIView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 28/01/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            StartShape()
            EndShape()
        }
        .background(Color(#colorLiteral(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, alpha: 0.8470588235)))
    }
}

struct StartShape: View {
    var body: some View{
        Rectangle()
            .fill(
                LinearGradient(colors: [Color.blue,Color(#colorLiteral(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, alpha: 0.8470588235))], startPoint: .top, endPoint: .bottom)
            )
            .frame(width: .infinity, height: 450)
            .overlay(
                VStack(alignment: .center) {
                    HStack {
                        Text("For You")
                            .foregroundStyle(Color.white)
                            .font(.title2.bold())
                            .padding(.leading, 20)
                        Rectangle()
                            .fill(Color.black.opacity(0))
                            .frame(width: .infinity,height: .infinity)
                            
                    }
                    RecommendedEntertainment()
                        
                        
                }
            )
        
            
    }
}

struct RecommendedEntertainment: View {
    
    @State private var imageData: Data?
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.black.opacity(0.2))
            .frame(width: 400,height: 400)
            .overlay(
                VStack() {
                    if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(systemName: "slowmo")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 200,height: 200)
                    }
                }
            )
    }
    
    func loadRecomendedImg() {
            
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/" ) else { return }

            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                }
            }.resume()
    
    }
}

struct EndShape: View {
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.3))
            .frame(width: .infinity, height: .infinity)
    }
}

#Preview {
    HomeView()
}
