//
//  LoginViewController.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 08/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        emailField.placeholder = "Email"
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
    private let passwordTextField: UITextField = {
           let passField = UITextField()
           passField.autocapitalizationType = .none
           passField.placeholder = "Password"
           passField.autocorrectionType = .no
           passField.layer.cornerRadius = 15
           passField.layer.borderWidth = 2
           passField.layer.borderColor = UIColor.darkGray.cgColor
           passField.leftView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 10,
                                                     height: 0))
           passField.leftViewMode = .always
           passField.backgroundColor = .white
        passField.isSecureTextEntry = true
        passField.returnKeyType = .done
           return passField
       }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .cyan
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    private let RegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        RegisterButton.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(RegisterButton)
        scrollView.isUserInteractionEnabled = true

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        passwordTextField.frame = CGRect(x: 30,
                                         y: emailTextField.bottom + 10,
                                         width: scrollView.width-60,
                                         height: 50)
        loginButton.frame = CGRect(x: 30,
                                   y: passwordTextField.bottom + 10,
                                   width: scrollView.width-60,
                                   height: 50)
        RegisterButton.frame = CGRect(x: 30,
                                   y: loginButton.bottom + 50,
                                   width: scrollView.width-60,
                                   height: 50)
    }
    
    @objc private func loginButtonTapped() {
        
       guard let email = emailTextField.text, let pass = passwordTextField.text, !email.isEmpty,
        !pass.isEmpty, pass.count >= 6 else {
            errorMessageAlert()
            return
        }
    }
    func errorMessageAlert() {
        let alert = UIAlertController(title: "ErrorMessage", message: "Something went wrong", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func RegisterButtonTapped() {
        let nav = RegistrationViewController()
        navigationController?.pushViewController(nav, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            loginButtonTapped()
        }
        return true
    }
}
