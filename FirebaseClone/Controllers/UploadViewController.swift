//
//  UploadViewController.swift
//  FirebaseClone
//
//  Created by Nurettin on 24.04.2019.
//  Copyright © 2019 readknit team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuth
import FirebaseDatabase

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.backgroundColor = UIColor.gray
        img.sizeToFit()
        img.isUserInteractionEnabled = true
        
        return img
    }()
    
    @objc func handleTapImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let orderNameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "ürün adı"
        field.textColor = UIColor.gray
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        
        //Modify Cursor Point Left Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        field.leftView = padding
        field.leftViewMode = .always
        return field
    }()
    
    let priceTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "fiyat"
        field.textColor = UIColor.gray
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        
        //Modify Cursor Point Left Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        field.leftView = padding
        field.leftViewMode = .always
        return field
    }()
    
    let postButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Gönder", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width * 0.055)
        btn.backgroundColor = UIColor.blue
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handlePostButton), for: .touchUpInside)
        
        return btn
    }()

     @objc func handlePostButton() {
        //resmi firebase e kayıt ettirmek
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = NSUUID().uuidString
            
            let mediaImagesRef = mediaFolder.child("\(uuid).jpg")
            mediaImagesRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    let alert  = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    mediaImagesRef.downloadURL(completion: { (url, error) in
                        if error == nil {
                            //database
                            let imageUrl = url?.absoluteURL
                            let dataBaseRefence = Database.database().reference()
                            let post = ["image" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "orderName" : self.orderNameTextField.text!, "price" : self.priceTextField.text!, "uuid" : uuid] as [String : Any]
                        dataBaseRefence.child("userUploads").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                            
                            //print("url: \(url?.absoluteString)")
                        }
                    })
                    
                }
            }
        }
    }
    
    func setupViews() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.45).isActive = true
        
        view.addSubview(orderNameTextField)
        orderNameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        orderNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        orderNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        orderNameTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(priceTextField)
        priceTextField.topAnchor.constraint(equalTo: orderNameTextField.bottomAnchor, constant: 15).isActive = true
        priceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        priceTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        priceTextField.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        view.addSubview(postButton)
        postButton.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 15).isActive = true
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        postButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.15).isActive = true
        
        //        view.addSubview(label)
        //        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        //        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8).isActive = true
        //        label.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2).isActive = true
    }
}
