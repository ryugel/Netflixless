//
//  Login_LogoutViewModel.swift
//  Netflixless
//
//  Created by Gilberto Pires da Silva Filho on 04/02/2024.
//

import SwiftUI

class Login_LogoutViewModel: ObservableObject {
    
    @Published var inscriptionReussie = false
    @Published var isConnected = false
    @Published var isConnectedfailed = false

    func inscrire(lastname: String, firstname: String, mail: String, password: String, birthday: Date) {
        let postUrl = URL(string: "https://netflixless.queijosdubeto.fr/users")!
        if lastname.isEmpty || firstname.isEmpty || mail.isEmpty || password.isEmpty {
            print("Error: les champs ne peuvent pas être vide")
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let birthdayString = dateFormatter.string(from: birthday)

        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json: [String: Any] = ["lastname": lastname,
                                "firstname": firstname,
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
                    DispatchQueue.main.async {
                        self.inscriptionReussie = true
                    }
                } else {
                    print("Error: \(response.statusCode)")
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        dataTask.resume()
    }


    func connection(mail: String, password: String){
        
        let postUrl = URL(string: "https://netflixless.queijosdubeto.fr/users/login")!
        if mail.isEmpty || password.isEmpty {
            print("Error: les champs ne peuvent pas être vide")
            return
        }
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json: [String: Any] = ["mail": mail,
                                "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            guard let data = data, let response = res as? HTTPURLResponse, err == nil else {
                print("Error: \(err!)")
                return
            }

                if response.statusCode == 200 {
                    print(String(data: data, encoding: .utf8)!)
                    DispatchQueue.main.async {
                        self.isConnected = true
                        self.isConnectedfailed = false
                    }
                } else {
                    print("Error: \(response.statusCode)")
                    print(String(data: data, encoding: .utf8)!)
                    print("Connexion échouée !")
                    DispatchQueue.main.async {
                        self.isConnectedfailed = true
                        self.isConnected = false
                    }
                }
            }
        dataTask.resume()
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
