//
//  LoginViewController.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 08/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import JGProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
    let spinner = JGProgressHUD(style: .dark)
    private let scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
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
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    let fbLoginButton : FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["email,name,gender,dob"]
        return button
    }()
    private let forgotPassButton: UIButton = {
        let button = UIButton()
        button.setTitle("ForgotPassword", for: .normal)
        button.setTitleColor(.magenta, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchUpInside)
        forgotPassButton.addTarget(self, action: #selector(forgotPass), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        fbLoginButton.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(fbLoginButton)
        scrollView.addSubview(forgotPassButton)
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
        registerButton.frame = CGRect(x: 30,
                                      y: loginButton.bottom + 10,
                                      width: scrollView.width-60,
                                      height: 50)
        fbLoginButton.frame = CGRect(x: 30,
                                     y: registerButton.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 50)
        forgotPassButton.frame = CGRect(x: 30,
                                        y: fbLoginButton.bottom + 10,
                                        width: scrollView.width - 60,
                                        height: 50)
        //        forgotPassButton.frame.origin = CGPoint(x: 30, y: self.view.frame.size.height - forgotPassButton.frame.size.height - 20)
    }
    
    @objc private func loginButtonTapped() {
        
        guard let email = emailTextField.text, let pass = passwordTextField.text, !email.isEmpty,
            !pass.isEmpty, pass.count >= 6 else {
                errorMessageAlert(message: "Please enter all fields")
                return
        }
        spinner.show(in: view)
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pass) { (authResult, error) in
            DispatchQueue.main.async {
                self.spinner.dismiss()
            }
            if error != nil  {
                self.errorMessageAlert(message: "Email or Password are incorrect")
            }
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    func errorMessageAlert(message : String) {
        let alert = UIAlertController(title: "ErrorMessage", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func RegisterButtonTapped() {
        let nav = RegistrationViewController()
        navigationController?.pushViewController(nav, animated: true)
    }
    
    @objc private func forgotPass() {
        navigationController?.pushViewController(ForgotPassViewController(), animated: true)
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

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            return
        }
        
        let fbRequest = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, first_name,last_name, dob, gender,picture.type(large)"], tokenString: token, version: nil, httpMethod: .get)
        
        fbRequest.start(completionHandler: {_, result, error in
            guard let result = result as? [String : Any], error == nil else {
                print("error fetching graph request")
                return
            }
            print("\(result)")
            guard let firstname = result["first_name"] as? String,
                let lastname = result["last_name"] as? String,
                let email = result["email"] as? String,
                let gender = result["gender"] as? String,
                let dob = result["dob"] as? String,
                let picture = result["picture"] as? [String: Any],
                let data = picture["data"] as? [String : Any],
                let pictureUrl = data["url"] as? String else {
                    print("Failed to get data from facebook")
                    return
            }
            let chatAppUser = ChatUsers(firstName: firstname, lastName: lastname, email: email, dob: dob, gender: gender)
            DataBaseManager.shared.insertUser(with: chatAppUser, completion: {success in
                if success {
                    guard let url = URL(string: pictureUrl) else {
                        return
                    }
                    print("failed Downloading data from facebook")
                    URLSession.shared.dataTask(with: url) { (data, _, _) in
                        guard let data = data else {
                            return
                        }
                        print("got data from fb")
                        let filename = chatAppUser.profilePicFilename
                        StorageManager.shared.uploadProfilePic(with: data, fileName: filename, completion: { result in
                            switch result {
                            case .success(let downloadUrl) :
                                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                print(downloadUrl)
                            case .failure(let error) :
                                print("Storgae manager error is:\(error)")
                                
                            }
                        })
                    } .resume()
                    
                }
            })
            
            let credantial = FacebookAuthProvider.credential(withAccessToken: token)
            FirebaseAuth.Auth.auth().signIn(with: credantial) { (authResult, error) in
                guard authResult != nil, error == nil else {
                    print("Error while logging in with fb")
                    return
                }
                print("successfully logged in")
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        })
        
    }
    
    
}

