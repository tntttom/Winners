//
//  RegisterViewController.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/27/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: DesignableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.setBottomBorder(withColor: UIColor.white)
        passwordTextField.setBottomBorder(withColor: UIColor.white)
        nameTextField.setBottomBorder(withColor: UIColor.white)
        
        passwordTextField.delegate = self
        setupTextField()
        
    }
    

    
    //Register users into firebase
    @IBAction func registerPressed(_ sender: Any) {

        guard let email = usernameTextField.text, let password = passwordTextField.text, let  name = nameTextField.text else { return }
        
        //Creates the user
        Auth.auth().createUser(withEmail: email, password: password, completion:  { (user,error) in
            //Error
            if error != nil {
                print(error)
                return
            }
        
            guard let uid = user?.user.uid else { return }
            
            //Success
            let ref = Database.database().reference()
            let usersReference = ref.child("users").child(uid)
            
            let values = ["names": name, "email": email, "password" : password]
                
            //Add to database
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                if err != nil {
                    print(err)
                    return
                }
                self.performSegue(withIdentifier: "goToMain", sender: self)
                print("Saved user successfully into firebaseDB")
            })

        })
    }
    
    func setupTextField() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
}

