//
//  Constants.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 17/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import Foundation

class Constants {
    
    static func isValidPassword(password : String) {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        passwordTest.evaluate(with: password)
    }
    
    static func isValidEmail(email : String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        emailPred.evaluate(with: email)
    }
    
    static func isValidPhone(phone : String) {
        let phoneRegex = "^[7-9][0-9]{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        phoneTest.evaluate(with: phone)
    }

}
