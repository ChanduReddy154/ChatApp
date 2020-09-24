//
//  ChatUsers.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 15/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import Foundation
struct ChatUsers {
    let firstName : String
    let lastName : String
    let email : String
    let dob : String
    let gender : String
    var profilePicFilename : String {
        return "\(safeEmail)_profile_picture.png"
    }
var safeEmail : String {
        var safeEmailAddress = email.replacingOccurrences(of: ".", with: "-")
        safeEmailAddress = safeEmailAddress.replacingOccurrences(of: "@", with: "-")
        return safeEmailAddress
    }

var safeDob : String {
        var safeDob = dob.replacingOccurrences(of: "/", with: "-")
        safeDob = safeDob.replacingOccurrences(of: ".", with: "-")
        return safeDob
    }
}


//    var safeEmailAdd : String {
//        var emailSafe = email.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
//        emailSafe?.removingPercentEncoding
//        emailSafe = email
//        return emailSafe!
//        }
//
//    var safePassWrd : String {
//        var safePasswrd = passWrd.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
//        safePasswrd?.removingPercentEncoding
//        safePasswrd = passWrd
//        return safePasswrd!
//    }
//
//    var safeDob : String {
//        var safeDateOfBirth = dob.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
//        safeDateOfBirth?.removingPercentEncoding
//        safeDateOfBirth = dob
//        return safeDateOfBirth!
//    }


//    var safePass : String {
//        var safePass = passWrd.replacingOccurrences(of: "@", with: "-")
//        safePass = safePass.replacingOccurrences(of: "#", with: "-")
//        safePass = safePass.replacingOccurrences(of: "$", with: "-")
//        safePass = safePass.replacingOccurrences(of: ".", with: "-")
//        return safePass
//    }
