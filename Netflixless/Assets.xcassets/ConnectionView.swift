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
    
    @State var text: String = UserDefaults.standard.string(forKey: "USER_ID") ?? ""

    @StateObject private var LoginLogoutViewmodel = Login_LogoutViewModel()

    var body: some View {

        NavigationView {
        
            GeometryReader { geometry in
                ZStack {
                    
                    Color(red: 0.2, green: 0.2, blue: 0.2)
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        
                        NetflixlessTitle()
                        Text("Connexion")
                            .foregroundColor(Color.white)
                            .font(.bold(.largeTitle)())
                            .padding(.bottom, 200)
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
                            ButtonConnection()
                        }
                        NavigationLink("", destination: MainView(), isActive: $LoginLogoutViewmodel.isConnected)
                    }
                    .padding(20)
                }
            }
            .navigationBarBackButtonHidden(true)

        }
    }
    
}

#Preview {
    ConnectionView()
}
