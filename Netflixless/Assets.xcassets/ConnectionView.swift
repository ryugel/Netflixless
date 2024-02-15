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

    @State var authenticationFailed: Bool = false
    @State var athenticationSucceed: Bool = false

    @StateObject private var LoginLogoutViewmodel = Login_LogoutViewModel()

    var body: some View {

        NavigationView {
        
            GeometryReader { geometry in
                ZStack {

                    Color(red: 0.2, green: 0.2, blue: 0.2)
                        .edgesIgnoringSafeArea(.all)

                    Text("Netflixless")
                        .foregroundColor(Color.red)
                        .font(.system(size: 50).bold())
                        .position(x: geometry.size.width / 2, y: 100)

                    VStack {
                        Text("Connexion")
                            .foregroundColor(Color.white)
                            .font(.bold(.largeTitle)())
                        EmailTextfiel(mail: $mail)
                        PasswordSecureField(password: $password)
                        if LoginLogoutViewmodel.isConnectedfailed {
                            Text("Connexion échouée")
                                .offset(y: -10)
                                .foregroundColor(Color.red)
                        }
                        
                        Button(action: {
                            self.LoginLogoutViewmodel.connection(mail: self.mail, password: self.password)
                        }) {
                            Text("Se connecter")
                                .foregroundColor(Color.white)
                                .font(.bold(.title)())
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(Color.red)
                                .cornerRadius(10.0)
                        }
                        NavigationLink("", destination: MainView(), isActive: $LoginLogoutViewmodel.isConnected)
                    }.padding(20)
                }
            }
            .navigationBarBackButtonHidden(true)

        }
    }
    
}

#Preview {
    ConnectionView()
}

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
