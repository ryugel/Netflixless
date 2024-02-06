//
//  Login_LogoutViewModel.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 04/02/2024.
//

import Foundation

class Login_LogoutViewModel: ObservableObject {

    func inscrire(lastName: String, firstName: String, mail: String, password: String, birthday: Date){
        let postUrl = URL(string: "https://netflixless.queijosdubeto.fr/users")
        // l'api retourne : {"success":true,"message":"Created"}
        if lastName.isEmpty || firstName.isEmpty || mail.isEmpty || password.isEmpty {
            print("Error: les champs ne peuvent pas être vide")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let birthdayString = dateFormatter.string(from: birthday)

        var request = URLRequest(url: postUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json: [String: Any] = ["lastname": lastName, 
                                "firstname": firstName, 
                                "mail": mail, 
                                "password": password, 
                                "birthday": birthdayString]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            guard let data = data, let response = res as? HTTPURLResponse, err == nil else {
                print("Error: \(err!)")
                return
            }

            if response.statusCode == 200 {
                print(String(data: data, encoding: .utf8)!)
            } else {
                print("Error: \(response.statusCode)")
                print(String(data: data, encoding: .utf8)!)
            }
        }
        dataTask.resume()
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
