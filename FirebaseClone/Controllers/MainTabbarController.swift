//
//  MainViewController.swift
//  FirebaseClone
//
//  Created by Nurettin on 24.04.2019.
//  Copyright © 2019 readknit team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIGraphicsEndImageContext()
        UITabBar.appearance().tintColor = UIColor.darkGray
        view.backgroundColor = UIColor.white
        
        viewControllers = [createControllerWidthTitle(title: "Feed", imageName: ""), createControllerWidthTitle1(title: "Upload", imageName: "")]
    }
    

    private func createControllerWidthTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = FeedViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
    private func createControllerWidthTitle1(title: String, imageName: String) -> UINavigationController {
        let viewController = UploadViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
            guard let username = snapshot.value as? String else { return }
            //self.welcomeLabel.text = "Welcome, \(username)"
            
            UIView.animate(withDuration: 0.5, animations: {
                //self.welcomeLabel.alpha = 1
            })
        }
    }
}
