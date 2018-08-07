//
//  AddEventViewController.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/31/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class AddEventViewController: UIViewController, UITextFieldDelegate {
    //Text field outlets
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        
        setupDateTimePicker()
       
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.viewTapped(gestureRecognizaer:)))
        
        view.addGestureRecognizer(tapGesture)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
         timeTextField.delegate = self
    }
    
   
    //Press add then adds the data to the firebase database in a structured way
    @IBAction func addButtonPressed(_ sender: Any) {
        //Checks to see if fields are not empty
        guard let eventName = eventNameTextField.text, let address = addressTextField.text, let city = cityTextField.text, let date = dateTextField.text, let time = timeTextField.text else {return}
        
        //Create db ref to create Events node
        let ref = Database.database().reference()
        let eventRef = ref.child("Events")
        
        //get users into the event details for confirmation
        
        
        //Child node of events, Name + info
        let eventInfoRef = eventRef.child(eventName)
        let eventInfoValues = ["address": address, "city": city, "date": date, "time": time]
        
        //Adds event info to db
        eventInfoRef.updateChildValues(eventInfoValues) { (err1, ref) in
            //Error
            if err1 != nil {
                print(err1)
                return
            }
            //Success
            print("Saved event info successfully into firebaseDB")
        }

       navigationController?.popViewController(animated: true)
        
    }
    
     //Datepicker stuff
    func setupDateTimePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        dateTextField.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(AddEventViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timeTextField.inputView = timePicker
        
        timePicker.addTarget(self, action: #selector(AddEventViewController.timeChanged(timePicker:)), for: .valueChanged)
    }
    
    //Should updte text field after picker view is chosen
    @objc func viewTapped(gestureRecognizaer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //Handles change of date
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    //Handles textfield entry
    @objc func timeChanged(timePicker: UIDatePicker) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        timeTextField.text = timeFormatter.string(from: timePicker.date)
    }
    
    
    //Bottom borders for text fields
    func setupTextFields() {
        eventNameTextField.setBottomBorder(withColor: .black)
        addressTextField.setBottomBorder(withColor: .black)
        cityTextField.setBottomBorder(withColor: .black)
        dateTextField.setBottomBorder(withColor: .black)
        timeTextField.setBottomBorder(withColor: .black)
    }
    
    //Keyboards should close out
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
