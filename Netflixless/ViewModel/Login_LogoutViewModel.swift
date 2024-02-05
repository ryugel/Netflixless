//
//  Login_LogoutViewModel.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 04/02/2024.
//

import Foundation

class Login_LogoutViewModel: ObservableObject {

    func inscrire(lastName: String, firstName: String, mail: String, password: String){
        let url = URL(string: "https://netflixless.queijosdubeto.fr/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "lastName": lastName,
            "firstName": firstName,
            "mail": mail,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                // Traitez la réponse ici...
//            }
        }.resume()
    }

    func connection(mail: String, password: String){
        let url = URL(string: "https://netflixless.queijosdubeto.fr/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                // Traitez la réponse ici...
//            }
        }.resume()
    }
}
