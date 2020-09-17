//
//  RegistrationViewController.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 08/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{
    
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    let genderItems = ["Male", "Female", "Other"]
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let FirstNameTextField: UITextField = {
        let fnameField = UITextField()
        fnameField.placeholder = "FirstName"
        fnameField.autocorrectionType = .no
        fnameField.layer.cornerRadius = 15
        fnameField.layer.borderWidth = 2
        fnameField.layer.borderColor = UIColor.darkGray.cgColor
        fnameField.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 10,height: 0))
        fnameField.leftViewMode = .always
        fnameField.backgroundColor = .white
        fnameField.returnKeyType = .continue
        return fnameField
    }()
    
    private let lastNameTextField: UITextField = {
        let lnameField = UITextField()
        lnameField.placeholder = "LastName"
        lnameField.autocorrectionType = .no
        lnameField.layer.cornerRadius = 15
        lnameField.layer.borderWidth = 2
        lnameField.layer.borderColor = UIColor.darkGray.cgColor
        lnameField.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 10,height: 0))
        lnameField.leftViewMode = .always
        lnameField.backgroundColor = .white
        lnameField.returnKeyType = .continue
        return lnameField
    }()
    private let dobTextField: UITextField = {
        let dobField = UITextField()
        dobField.placeholder = "DOB"
        dobField.layer.cornerRadius = 15
        dobField.layer.borderWidth = 2
        dobField.layer.borderColor = UIColor.darkGray.cgColor
        dobField.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 10,height: 0))
        dobField.leftViewMode = .always
        dobField.backgroundColor = .white
        dobField.returnKeyType = .continue
        return dobField
    }()
    private let genderTextField: UITextField = {
        let genderField = UITextField()
        genderField.placeholder = "Gender"
        genderField.layer.cornerRadius = 15
        genderField.layer.borderWidth = 2
        genderField.layer.borderColor = UIColor.darkGray.cgColor
        genderField.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 10,height: 0))
        genderField.leftViewMode = .always
        genderField.backgroundColor = .white
        genderField.returnKeyType = .continue
        return genderField
    }()
    private let emailTextField: UITextField = {
        let emailField = UITextField()
        emailField.autocapitalizationType = .none
        emailField.placeholder = "Email"
        emailField.autocorrectionType = .no
        emailField.layer.cornerRadius = 15
        emailField.layer.borderWidth = 2
        emailField.layer.borderColor = UIColor.darkGray.cgColor
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
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
        passField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passField.leftViewMode = .always
        passField.backgroundColor = .white
        passField.isSecureTextEntry = true
        passField.returnKeyType = .done
        return passField
    }()
    private let registerButton: UIButton = {
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
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        FirstNameTextField.delegate = self
        lastNameTextField.delegate = self
       // dobTextField.delegate = self
       // genderTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        genderPicker.delegate = self
        genderPicker.dataSource = self
        //animateButton(button: registerButton)
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(FirstNameTextField)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(dobTextField)
        scrollView.addSubview(genderTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
        showDatePicker()
        pickerGender()
        imageView.isUserInteractionEnabled =  true
        scrollView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profilePicTapped))
        imageView.addGestureRecognizer(gesture)
    }
    @objc func profilePicTapped() {
        presentActionSheet()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        FirstNameTextField.frame = CGRect(x: 30,
                                          y: imageView.bottom + 10,
                                          width: scrollView.width-60,
                                          height: 50)
        lastNameTextField.frame = CGRect(x: 30,
                                         y: FirstNameTextField.bottom + 10,
                                         width: scrollView.width-60,
                                         height: 50)
        dobTextField.frame = CGRect(x: 30,
                                    y: lastNameTextField.bottom + 10,
                                    width: scrollView.width-60,
                                    height: 50)
        genderTextField.frame = CGRect(x: 30,
                                    y: dobTextField.bottom + 10,
                                    width: scrollView.width-60,
                                    height: 50)
        emailTextField.frame = CGRect(x: 30,
                                      y: genderTextField.bottom + 10,
                                      width: scrollView.width-60,
                                      height: 50)
        passwordTextField.frame = CGRect(x: 30,
                                         y: emailTextField.bottom + 10,
                                         width: scrollView.width-60,
                                         height: 50)
        registerButton.frame = CGRect(x: 30,
                                      y: passwordTextField.bottom + 20,
                                      width: scrollView.width-60,
                                      height: 50)
    }
    /*   func animateButton(button: UIButton) {
     let animateButton = UIView(frame: CGRect(x: button.bounds.maxX, y: button.bounds.maxY, width: button.bounds.width/2, height: button.bounds.height))
     animateButton.isUserInteractionEnabled = true
     let gradientView = CAGradientLayer()
     gradientView.frame = animateButton.bounds
     gradientView.colors = [UIColor.magenta.cgColor, UIColor.black.cgColor]
     gradientView.locations = [0, 1.0]
     gradientView.startPoint = CGPoint(x: 1.0, y: 1.0)
     gradientView.endPoint = CGPoint(x: 0, y: 0)
     gradientView.opacity = 0.5
     animateButton.layer.addSublayer(gradientView)
     button.addSubview(animateButton)
     UIView.animate(withDuration: 1.5, delay: 0, options: .repeat, animations: {
     animateButton.transform = animateButton.transform.translatedBy(x: -button.bounds.maxX * 1.5, y: 0)
     }, completion: nil)
     } */
    
    @objc private func registerButtonTapped() {
        
        guard let fname = FirstNameTextField.text, let lName = lastNameTextField.text, let dob = dobTextField.text, let gender = genderTextField.text, let email = emailTextField.text, let pass = passwordTextField.text, !fname.isEmpty, !lName.isEmpty, !email.isEmpty, !dob.isEmpty, !gender.isEmpty,
            !pass.isEmpty, pass.count >= 6 else {
                errorMessageAlert(message: "Please enter all fields")
                return
            }
        //Firebase Register
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
            if error != nil {
                self.errorMessageAlert(message: "Email Already Exists")
                return
            }
            DataBaseManager.shared.insertUser(with: ChatUsers(firstName: fname, lastName: lName, email: email, dob: dob, gender: gender, passWrd: pass))
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
    }
    func errorMessageAlert(message : String) {
        let alert = UIAlertController(title: "ErrorMessage", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
   func showDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker
        
    }
    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        dobTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == FirstNameTextField {
            lastNameTextField.becomeFirstResponder()
        }else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
            //dobTextField.becomeFirstResponder()
        }//else if textField == dobTextField {
        else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            registerButtonTapped()
        }
        return true
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate {
    
    func presentActionSheet() {
        let alert = UIAlertController(title: "Profile Picture", message: "How would you like to choose profile pic", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Camera",
                                      style: .default,
                                      handler: {_ in
                                        self.accessCamera()
        }))
        alert.addAction(UIAlertAction(title: "Photo Library",
                                      style: .default,
                                      handler: {_ in
                                        self.accessPhotoLibrary()
        }))
        present(alert, animated: true)
    }
    
    func accessCamera() {
        let pic = UIImagePickerController()
        pic.allowsEditing = true
        pic.delegate = self
        pic.sourceType = .camera
        present(pic, animated: true)
    }
    func accessPhotoLibrary() {
        let pic = UIImagePickerController()
        pic.allowsEditing = true
        pic.delegate = self
        pic.sourceType = .photoLibrary
        present(pic, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.imageView.image = imageSelected
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

 extension RegistrationViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderItems.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderItems[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genderItems[row]
    }
    func pickerGender() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        genderTextField.inputAccessoryView = toolbar
        genderTextField.inputView = genderPicker
    }
    
    @objc private func donePicker() {
        genderTextField.resignFirstResponder()
    }
    
    @objc private func cancelPicker() {
        self.view.endEditing(true)
    }
}
