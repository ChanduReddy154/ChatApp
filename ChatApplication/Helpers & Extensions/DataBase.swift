//
//  DataBase.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 15/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let dataBaseref = Database.database().reference()
    
    func insertUser(with User: ChatUsers) {
        dataBaseref.child(User.safeEmail).setValue([
            "first_name" : User.firstName,
            "last_name" : User.lastName,
            "dob" : User.dob,
            "gender" : User.gender,
            "password" : User.passWrd
        ])
    }
    
}


