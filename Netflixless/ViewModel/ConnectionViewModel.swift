//
//  ConnectionViewModel.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 16/02/2024.
//

import SwiftUI

struct EmailTextfiel: View {
    
    @Binding var mail: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            TextField("",text: $mail)
                .padding()
                .background(Color.white)
                .keyboardType(.emailAddress)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .foregroundStyle(Color.black)
            if (self.mail.isEmpty) {
                Text("Mail")
                    .foregroundColor(Color.black)
                    .font(.system(size: 16))
                    .padding()
                    .padding(.top, -20)
            }
        }
    }
}

struct PasswordSecureField: View {

    @Binding var password: String

    var body: some View {
        ZStack (alignment: .leading) {
            SecureField("", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .foregroundColor(Color.black)
            if (self.password.isEmpty) {
                Text("Mot de passe")
                    .foregroundColor(Color.black)
                    .font(.system(size: 16))
                    .padding()
                    .padding(.top, -20)
            }
        }
    }
}

struct ButtonConnection: View {
    var body: some View {
        Text("Se connecter")
            .foregroundColor(Color.white)
            .font(.bold(.title)())
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.red)
            .cornerRadius(10.0)
    }
}

struct NetflixlessTitle: View {
    var body: some View {
        Text("Netflixless")
            .foregroundColor(Color.red)
            .font(.system(size: 50).bold())
    }
}
