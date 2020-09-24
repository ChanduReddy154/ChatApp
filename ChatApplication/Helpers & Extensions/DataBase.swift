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
    
    func insertUser(with User: ChatUsers, completion: @escaping (Bool) -> Void) {
        dataBaseref.child(User.safeEmail).setValue([
            "first_name" : User.firstName,
            "last_name" : User.lastName,
            "dob" : User.dob,
            "gender" : User.gender,
           // "password" : User.passWrd
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("Failed to write to the data base")
                completion(false)
                return
            }
            completion(true)
        })
    }
    
}


