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

class MainViewController: UIViewController{
    @IBOutlet weak var eventTableView: UITableView!
    
    @IBOutlet weak var gradientView: GradientView!
    
    var currentColorIndex = -1
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    var events = [Event]()
    var eventName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        
        eventTableView.dataSource = self
        
        eventTableView.delegate = self
        
        eventTableView.layer.borderColor = UIColor.white.cgColor
        eventTableView.layer.borderWidth = 1.0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if eventTableView.indexPathForSelectedRow == nil {
            loadEvents()
        }
        updateUser()
        setCustomBackImage()
        
    }
    
    func loadEvents() {
        
        Database.database().reference().child("Events").observe(.childAdded) { (eventSnapshot) in
           
            self.eventName.append(eventSnapshot.key)
            
            let eventInfoDict = eventSnapshot.value as? [String: Any]
            let address = eventInfoDict!["address"] as! String
            let city = eventInfoDict!["city"] as! String
            let date = eventInfoDict!["date"] as! String
            let time = eventInfoDict!["time"] as! String
            
            let event = Event(addressText: address, cityText: city, dateText: date, timeText: time)
            
            self.events.append(event)
            
            self.eventTableView.reloadData()
        }
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
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToAddEvent", sender: self)
        
    }
    
    
    func setCustomBackImage() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.gray
        
    }
    
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        cell.textLabel?.text = eventName[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 18)
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.clear
        eventTableView.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToEventDetail", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination.isKind(of: AddEventViewController.self){
            
            return
            
        } else if segue.destination.isKind(of: WelcomeViewController.self){
            
                return
            
            } else{
            
            let destinationVC = segue.destination as! EventDetailViewController
        
            if let indexPath = eventTableView.indexPathForSelectedRow {
                destinationVC.eventName = eventName[indexPath.row]
                destinationVC.currentEventIndex = indexPath.row
                destinationVC.events = events
                }
            }
        }

    }
