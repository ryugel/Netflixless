//
//  PageChoice.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 16/02/2024.
//

import SwiftUI

struct PageChoice: View {

    var body: some View {

        NavigationView {
        
            GeometryReader { geometry in
                ZStack {
                    
                    Color(red: 0.2, green: 0.2, blue: 0.2)
                        .edgesIgnoringSafeArea(.all)
                        
                    VStack {
                        NetflixlessTitle()
                        NavigationLink(destination: ConnectionView())
                        {
                        Text("Se connecter")
                            .foregroundColor(Color.white)
                            .font(.bold(.title)())
                            .padding()
                            .frame(width: 220, height: 50)
                            .background(Color.red)
                            .cornerRadius(10.0)
                        }
                        NavigationLink(destination: InscriptionView())
                        {
                        Text("S'inscrire")
                            .foregroundColor(Color.black)
                            .font(.bold(.title)())
                            .padding()
                            .frame(width: 220, height: 50)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }
                    }
                    .padding(20)
                }
            }
        }
    }
    
}

#Preview {
    PageChoice()
}

