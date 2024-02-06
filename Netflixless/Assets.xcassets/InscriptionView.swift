//
//  InscriptionView.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 02/02/2024.
//

import SwiftUI

struct InscriptionView: View {
    @State private var lastName: String = ""
    @State private var firstName: String = ""
    @State private var mail: String = ""
    @State private var password: String = ""
    @State private var birthday: Date = Date()

    private var inscription = Login_LogoutViewModel()

    var body: some View {

        let calendar = Calendar.current
        let earliestDate = calendar.date(byAdding: .year, value: -15, to: Date())!

        ZStack {
            Color(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, opacity: 0.8470588235)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Netflixless")
                    .foregroundColor(Color.red)
                    .padding(.bottom, 20)
                    .font(.system(size: 50).bold())
                Text("Inscription")
                    .foregroundColor(Color.white)
                    .font(.bold(.largeTitle)())
                TextField("Nom", text: $lastName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black)
                TextField("Prénom", text: $firstName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black)
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
                    self.inscription.inscrire(
                        lastName: self.lastName,
                        firstName: self.firstName,
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
            }.padding(20)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .background(
        Color(#colorLiteral(red: 0.1784488559, green: 0.1784488559, blue: 0.1784488559, alpha: 0.8470588235)))
    }
}

#Preview {
    InscriptionView()
}
