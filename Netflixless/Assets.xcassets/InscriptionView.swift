//
//  InscriptionView.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 02/02/2024.
//

import SwiftUI

struct InscriptionView: View {
    @State private var lastname: String = ""
    @State private var firstname: String = ""
    @State private var mail: String = ""
    @State private var password: String = ""
    @State private var birthday: Date = Date()

    @StateObject private var LoginLogoutViewmodel = Login_LogoutViewModel()

    var body: some View {
        
        NavigationView {
            
            let calendar = Calendar.current
            let earliestDate = calendar.date(byAdding: .year, value: -15, to: Date())!
            
            ZStack {
                Color(red: 0.2, green: 0.2, blue: 0.2)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Netflixless")
                        .foregroundColor(Color.red)
                        .padding(.bottom, 20)
                        .font(.system(size: 50).bold())
                    Text("Inscription")
                        .foregroundColor(Color.white)
                        .font(.bold(.largeTitle)())
                    LastNameTextField(lastname: $lastname)
                    FirstNameTextField(firstname: $firstname)
                    MailTextField(mail: $mail)
                    PasswordTextField(password: $password)
                    DatePicker(
                        "Date de naissance", selection: $birthday, in: ...earliestDate,
                        displayedComponents: .date
                    )
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .foregroundColor(Color.black)
                    Button(action: {
                        self.LoginLogoutViewmodel.inscrire(
                            lastname: self.lastname,
                            firstname: self.firstname,
                            mail: self.mail,
                            password: self.password,
                            birthday: self.birthday)
                    }) {
                        Text("S'inscrire")
                            .foregroundColor(Color.white)
                            .font(.bold(.title)())
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.red)
                            .cornerRadius(10.0)
                    }
                    NavigationLink("", destination: ConnectionView(), isActive: $LoginLogoutViewmodel.inscriptionReussie)
                }
                .padding(20)
            }
            
        }
    }
}

#Preview {
    InscriptionView()
}
