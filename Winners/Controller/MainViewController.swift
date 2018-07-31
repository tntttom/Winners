//
//  MainViewController.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/30/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUser()
        
        setCustomBackImage()
        
    }

    
    @IBAction func signoutPressed(_ sender: Any) {
        handleLogout()
    }
    
    
    //Handle Logout Functionality
    @objc func handleLogout() {
        
        do{
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let welcomeVC = WelcomeViewController()
        performSegue(withIdentifier: "goToWelcome" , sender: self)
        
    }
    
    func handleNoUserSignedIn() {
        //If no one is signed in, go to Welcome view controller + handle the sign out
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            
        }
    }
    
    //***CHECKS THE CORRECT USER IS LOGGED IN
    func updateUser() {
        let uid = Auth.auth().currentUser?.uid
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                Database.database().reference().child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        self.navigationItem.title = dictionary["names"] as? String
                        print(dictionary["names"] as? String)
                    }
                    
                }, withCancel: nil)
            } else {
                self.handleLogout()
            }
        }
        
    }
    
    func setCustomBackImage() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.gray
        
    }
    
    
}
