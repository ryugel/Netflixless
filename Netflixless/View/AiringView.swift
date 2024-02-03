//
//  Carousel.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import SwiftUI
import Kingfisher


struct OnTheAir: View {
    @State var searchText: String = ""
    @StateObject var vm = AiringViewModel()
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                Text("Netflixless")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.color1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.leading, 13)
                
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                       Text("On The Air")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: .buttonBorder)
                }
                
                GeometryReader { geo in
                    let size = geo.size
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(vm.airings, id:\.self) { location in
                                GeometryReader { proxy in
                                    let cardSize = proxy.size
                                    
                                    let minX = min((proxy.frame(in: .scrollView).minX - 30) * 1.4, size.width * 1.4)
                                    
                                    KFImage(URL(string: location.imageUrl + (location.posterPath ?? "")))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(x: -minX)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        //.overlay(LocationOverlay(location))
                                        .clipShape(.rect(cornerRadius: 15))
                                        .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
                                }
                                .frame(width: size.width - 60, height: size.height - 50)
                                .scrollTransition(.animated, axis: .horizontal) { view, phase in
                                    view
                                        .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .scrollTargetLayout()
                        .frame(height: size.height, alignment: .top)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                }
                .frame(height: 500)
                .padding(.horizontal, -15)
                .padding(.top, 20)
            }
            .padding(15)
            
        }
        .scrollIndicators(.hidden)
        .onAppear{
            vm.fetchAiringShows()
        }
    }
}

#Preview {
    OnTheAir()
}
