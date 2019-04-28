//
//  SignInViewController.swift
//  FirebaseClone
//
//  Created by Nurettin on 24.04.2019.
//  Copyright © 2019 readknit team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
        
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
    
    let signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign In", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width * 0.055)
        btn.backgroundColor = UIColor.blue
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handleSignInButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleSignInButton() {
        
        if mailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) { (userData, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    UserDefaults.standard.set(userData?.user.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberUser()
                }

            }
        }
        
    }
    
    
    
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
        print(123)
        let signUp = SignUpViewController()
        //navigationController?.pushViewController(signUp, animated: true)
        self.present(signUp, animated: true, completion: nil)
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.width * 0.070).isActive = true
        
        view.addSubview(mailTextField)
        mailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        mailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        mailTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        mailTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 15).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(signInButton)
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(signUpButton)
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 15).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
    }
}
