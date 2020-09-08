//
//  ViewController.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 17/08/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userLoggedIn = UserDefaults.standard.bool(forKey: "LoggedIn")
        
        if !userLoggedIn {
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

