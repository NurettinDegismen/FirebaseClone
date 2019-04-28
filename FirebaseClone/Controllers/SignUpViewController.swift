//
//  LogoutViewController.swift
//  FirebaseClone
//
//  Created by Nurettin on 24.04.2019.
//  Copyright © 2019 readknit team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    let exitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("X", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width * 0.055)
        btn.backgroundColor = UIColor.gray
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handleExitButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleExitButton() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Instagram Clone"
        lbl.textColor = UIColor.gray
        lbl.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width * 0.055)
        lbl.textAlignment = .center
        
        lbl.layer.borderColor = UIColor.black.cgColor
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    let nameTextField: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "username"
        name.textColor = UIColor.gray
        
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        
        //Modify Cursor Point Left Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        name.leftView = padding
        name.leftViewMode = .always
        return name
    }()
    
    let phoneTextField: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "phone"
        name.textColor = UIColor.gray
        
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        
        //Modify Cursor Point Left Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        name.leftView = padding
        name.leftViewMode = .always
        return name
    }()
    
    let mailTextField: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "email"
        name.textColor = UIColor.gray
        
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        
        //Modify Cursor Point Left Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        name.leftView = padding
        name.leftViewMode = .always
        return name
    }()
    
    let passwordTextField: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "password"
        name.textColor = UIColor.gray
        
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        
        //Modify Cursor Point Left Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        name.leftView = padding
        name.leftViewMode = .always
        return name
    }()
    
    let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width * 0.055)
        btn.backgroundColor = UIColor.gray
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleSignUpButton() {
        
        guard let username = nameTextField.text else { return }
        guard let phone = phoneTextField.text else { return }
        guard let email = mailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        createUser(username: username, phone: phone, email: email, password: password)
//        if self.mailTextField.text != "" && self.passwordTextField.text != "" {
//
//            Auth.auth().createUser(withEmail: mailTextField.text!, password: passwordTextField.text!) { (userData, error) in
//
//                if error != nil {
//                    let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
//                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
//                    alert.addAction(okButton)
//                    self.present(alert, animated: true, completion: nil)
//                }else{
//                    let mainPage = MainTabbarController()
//                    self.present(mainPage, animated: true, completion: nil)
//                }
//            }
//
//        }else{
//            let alert = UIAlertController(title: "Error", message: "Username or Password Can't Be Empty!", preferredStyle: UIAlertController.Style.alert)
//            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
//            alert.addAction(okButton)
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    //CREATE APİ
    
    
    
    func createUser(username: String, phone: String, email: String, password: String) {
        
        if nameTextField.text != "" && phoneTextField.text != "" && mailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
                
                guard let uid = result?.user.uid else { return }
                let values = ["username": username, "phone": phone, "email": email, "password": password]
                
                Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        let alert = UIAlertController(title: "Failed to update database values with error:", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        let nv = MainTabbarController()
                        self.present(nv, animated: true, completion: nil)
                        
                        UserDefaults.standard.set(result?.user.email, forKey: "user")
                        UserDefaults.standard.synchronize()
                        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        delegate.rememberUser()
                    }
                    
                })
            }
        }else{
            let alert = UIAlertController(title: "Error!", message: "Cannat be empty!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
 
    func setupViews() {
        view.addSubview(exitButton)
        exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.045).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.045).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.width * 0.070).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25).isActive = true
        phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        phoneTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(mailTextField)
        mailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 25).isActive = true
        mailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        mailTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        mailTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 25).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(signUpButton)
        signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
    }

}
