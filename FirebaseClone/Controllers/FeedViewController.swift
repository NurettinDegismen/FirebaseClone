//
//  ViewController.swift
//  FirebaseClone
//
//  Created by Nurettin on 24.04.2019.
//  Copyright © 2019 readknit team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Çıkış", style: .done, target: self, action: #selector(handleSignOut))
        setupViews()
        //register table view
        tableView.register(AppTableCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.frame = table.frame
        return table
    }()

    @objc func handleSignOut() {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let signIn = SignInViewController()
        self.present(signIn, animated: true, completion: nil)
        
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signIn
        delegate.rememberUser()
        
        do {
            try Auth.auth().signOut()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AppTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

class AppTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let imgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "damacana")
        img.contentMode = .scaleAspectFit
        img.sizeToFit()
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "19 litre damacana"
        lbl.textColor = UIColor.black
        
        lbl.layer.borderColor = UIColor.black.cgColor
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "₺19.00"
        lbl.textColor = UIColor.black
        lbl.textAlignment = .right
        lbl.layer.borderColor = UIColor.black.cgColor
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    let buton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("sepete ekle", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.purple
        return btn
    }()
    
    func setupViews() {
        addSubview(imgView)
        imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        imgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: frame.width * 0.3).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: frame.width * 0.3).isActive = true
        
        addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 0).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: frame.width * 0.7).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: frame.width * 0.065).isActive = true
        
        addSubview(priceLabel)
        priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: frame.width * 0.2).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: frame.width * 0.065).isActive = true
        
        addSubview(buton)
        buton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        buton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        buton.widthAnchor.constraint(equalToConstant: frame.width * 0.25).isActive = true
        buton.heightAnchor.constraint(equalToConstant: frame.width * 0.065).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
