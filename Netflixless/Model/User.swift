//
//  User.swift
//  Netflixless
//
//  Created by Augustin Diabira on 22/01/2024.
//

import Foundation

struct User: Identifiable {
    var id: UUID
    var username: String
    var password: String
    var lastName: String
    var firstName:String
    var birthdate:Date
    
    var age: Int {
        let calendar = Calendar.current
        let today = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: today)
        return ageComponents.year ?? 0
    }
    
    var isAdult: Bool {
        return age >= 18
    }
}

func birthday(from dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    return dateFormatter.date(from: dateString)
}
