//
//  InscriptionView.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 02/02/2024.
//

import SwiftUI

struct InscriptionView: View {
    var body: some View {
        ZStack {
            Color(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, opacity: 0.8470588235)

            VStack {
                Text("Inscription")
                    .foregroundColor(Color.white)
                    .font(.bold(.largeTitle)())
                TextField("Nom", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black)
                TextField("Prénom", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black)
                TextField("Mail", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black)
                TextField("Mot de passe", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black)
                TextField("Date de naissance", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black)
                Button(action: {
                    // action
                }) {
                    Text("S'inscrire")
                        .foregroundColor(Color.white)
                        .font(.bold(.title)())
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.red)
                        .cornerRadius(10.0)
                }
            }.padding(20)
        }
        .background(Color(#colorLiteral(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, alpha: 0.8470588235)))
    }
}

#Preview {
    InscriptionView()
}
