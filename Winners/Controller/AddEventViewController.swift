//
//  AddEventViewController.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/31/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import Foundation
import UIKit

class AddEventViewController: UIViewController {
    @IBOutlet weak var eventNameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var addButtonPressed: ButtonBounce!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTextFields()
        
    }
    
    func setupTextFields() {
        eventNameTextField.setBottomBorder(withColor: .black)
        addressTextField.setBottomBorder(withColor: .black)
        cityTextField.setBottomBorder(withColor: .black)
        dateTextField.setBottomBorder(withColor: .black)
        timeTextField.setBottomBorder(withColor: .black)
    }
    
    
}
