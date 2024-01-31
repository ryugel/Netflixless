//
//  SwiftUIView.swift
//  Netflixless
//
//  Created by Gil Rodrigues on 28/01/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            StartShape()
            EndShape()
        }
        .background(Color(.black))
    }
}

struct StartShape: View {
    var body: some View{
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .fill(
                LinearGradient(colors: [Color.blue,Color.black], startPoint: .top, endPoint: .bottom)
            )
            .frame(width: .infinity, height: 450)
            .overlay(
                VStack(alignment: .leading) {
                    Text("For You")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .padding(.leading, 20)
                    
                    RecommendedEntertainment()
                        
                        
                }
            )
        
            
    }
}

struct RecommendedEntertainment: View {
    var body: some View {
        
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.black.opacity(0.2))
            .frame(width: 400,height: 400)
            .overlay(
                VStack() {
                    Image(systemName: "slowmo")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 200,height: 200)
                }
            )
        
        
    }
}

struct EndShape: View {
    var body: some View {
        Rectangle()
            .fill(
                Color(.black)
            )
            .frame(width: .infinity, height: .infinity)
    }
}

#Preview {
    HomeView()
}
