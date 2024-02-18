//
//  User.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID
    var username: String
    var password: String
    var lastName: String
    var firstName: String
    var birthdate: Date
    
    var age: Int {
        let calendar = Calendar.current
        let today = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: today)
        return ageComponents.year ?? 0
    }
    
    var isAdult: Bool {
        return age >= 18
    }
    
    static let user = User(id: UUID(), username: "Tay", password: "nei,lxz,p", lastName: "Von Degurechaff", firstName: "Taylor", birthdate: birthday(from: "31-12-2002") ?? Date())
}

func birthday(from dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    return dateFormatter.date(from: dateString)
}
