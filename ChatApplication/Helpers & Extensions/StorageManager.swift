//
//  StorageManager.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 24/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private var storageRef = Storage.storage().reference()
    
   func uploadProfilePic(with data:Data, fileName : String, completion: @escaping (Result<String, Error>) -> Void) {
        storageRef.child("images/\(fileName)").putData(data, metadata: nil, completion: {metaData, error in
            guard error == nil else {
                print("Error while uploading profile pic")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self.storageRef.child("images/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to get URL")
                    completion(.failure(StorageErrors.failedToGetUrl))
                    return
                }
                let urlString = url.absoluteString
                print("Downloaded url is\(urlString)")
                completion(.success(urlString))
            }
        })
        
    }
    public enum StorageErrors : Error {
        case failedToUpload
        case failedToGetUrl
    }
}
