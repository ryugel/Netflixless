//
//  ConnectionView.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 04/02/2024.
//

import SwiftUI

struct ConnectionView: View {
    
    @State private var mail: String = ""
    @State private var password: String = ""

    private var connection = Login_LogoutViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {

                Color(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, opacity: 0.8470588235)
                    .edgesIgnoringSafeArea(.all)

                Text("Netflixless")
                    .foregroundColor(Color.red)
                    .font(.system(size: 50).bold())
                    .position(x: geometry.size.width / 2, y: 100)

                VStack {
                    Text("Connexion")
                        .foregroundColor(Color.white)
                        .font(.bold(.largeTitle)())
                    TextField("Mail", text: $mail)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .foregroundColor(Color.black)
                    TextField("Mot de passe", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .foregroundColor(Color.black)
                    Button(action: {
                        self.connection.connection(mail: mail, password: password)
                    }) {
                        Text("Se connecter")
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
}

#Preview {
    ConnectionView()
}
