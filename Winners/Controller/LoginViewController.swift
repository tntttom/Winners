//
//  LoginViewController.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/26/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.setBottomBorder(withColor: UIColor.white)
        passwordTextField.setBottomBorder(withColor: UIColor.white)
        
        passwordTextField.delegate = self
        setupTextField()
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Login Successful")
                self.performSegue(withIdentifier: "goToMain", sender: self)
                
            }
            
            
        }
    }
    
    
    
    func setupTextField() {
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

extension UITextField
{
    func setBottomBorder(withColor color: UIColor)
    {
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 1.0
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
    }
}
