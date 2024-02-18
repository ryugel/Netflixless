//
//  InscriptionViewModel.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 16/02/2024.
//

import SwiftUI

struct LastNameTextField: View {
    
    @Binding var lastname: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            TextField("",text: $lastname)
                .padding()
                .background(Color.white)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .foregroundStyle(Color.black)
                .onSubmit {
                    
                }
            if (self.lastname.isEmpty) {
                Text("Nom")
                    .foregroundColor(Color.black)
                    .font(.system(size: 16))
                    .padding()
                    .padding(.top, -20)
            }
        }
    }
}

struct FirstNameTextField: View {
    
    @Binding var firstname: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            TextField("",text: $firstname)
                .padding()
                .background(Color.white)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .foregroundColor(Color.black)
            if (self.firstname.isEmpty) {
                Text("Prénom")
                    .foregroundColor(Color.black)
                    .font(.system(size: 16))
                    .padding()
                    .padding(.top, -20)
            }
        }
    }
}

struct MailTextField: View {
    
    @Binding var mail: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            TextField("",text: $mail)
                .padding()
                .background(Color.white)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .keyboardType(.emailAddress)
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

struct PasswordTextField: View {
    
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
