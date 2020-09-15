//
//  ForgotPassViewController.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 15/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import UIKit
import Firebase

class ForgotPassViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let emailField = UITextField()
        emailField.autocapitalizationType = .none
        emailField.placeholder = "Please Enter Email"
        emailField.autocorrectionType = .no
        emailField.layer.cornerRadius = 15
        emailField.layer.borderWidth = 2
        emailField.layer.borderColor = UIColor.darkGray.cgColor
        emailField.leftView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 10,
                                                   height: 0))
        emailField.leftViewMode = .always
        emailField.backgroundColor = .white
        emailField.returnKeyType = .continue
        return emailField
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .cyan
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        forgotButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(forgotButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        emailTextField.frame = CGRect(x: 30,
                                      y: imageView.bottom + 10,
                                      width: scrollView.width-60,
                                      height: 50)
        forgotButton.frame = CGRect(x: 30,
                                      y: emailTextField.bottom + 10,
                                      width: scrollView.width-60,
                                      height: 50)
        
    }
    
    @objc private func buttonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            errorMessage()
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
        if error != nil {
            return
        }else {
            //self.errorMessage("The reset link is sent to your mail")
            let alert = UIAlertController(title: "ResetPassword", message: "The reset link is sent to your mail", preferredStyle: UIAlertController.Style.alert)
            
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)  { (action) in
                self.emailTextField.text = ""
            }
            
            alert.addAction(alertAction)
            self.present(alert, animated: true)
            
        }
    }
    
}
    
    func errorMessage() {
        let alert = UIAlertController(title: "ErrorMessage", message: "Please enter email", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
