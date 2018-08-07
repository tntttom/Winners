//
//  ViewController.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/26/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class EventDetailViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    //Data model arrays
    var users = [User]()
    var events = [Event]()
    var eventName: String? {
        didSet{
            loadInfo()
            loadUsersIntoDB()
            populateTableUsers()
        }
    }
    
    var currentEventIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomBackImage()
        
        //DO NOT FORGET TO DO THIS
        userTableView.dataSource = self
        userTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = false
        eventNameLabel.text = eventName
    }
    
    
    // Loads the Information to display
    func loadInfo() {
        Database.database().reference().child("Events").child(eventName!).observe(.childAdded) { (eventInfoSnapshot) in
            
            print(eventInfoSnapshot)
            
            self.dateLabel.text = self.events[self.currentEventIndex!].date
            self.timeLabel.text = self.events[self.currentEventIndex!].time
            self.addressLabel.text = self.events[self.currentEventIndex!].address
            self.cityLabel.text = self.events[self.currentEventIndex!].city
        }
    }
    
    //Get users from user node to get put into each individual event node to see who is going or not
    func loadUsersIntoDB() {
        Database.database().reference().child("users").observe(.childAdded) { (userSnap) in
            
            let userDict = userSnap.value as? [String: Any]
            let userID = userSnap.key
            let userName = userDict!["names"] as! String
            let userGoing = false
            
            let eventUserValue = ["name": userName, "going": userGoing] as [String : Any]
            
            let eventUserRef = Database.database().reference().child("Events").child(self.eventName!).child("users").child(userID)
            
                eventUserRef.updateChildValues(eventUserValue, withCompletionBlock: { (error, ref) in
                
                    if error != nil {
                        print(error)
                        return
                }
            })
        }
    }
    
    
    //Gets users from DB and populates it by appending the users to an array of users and then using that to populate in datasource methods
    func populateTableUsers() {
        
        Database.database().reference().child("Events").child(self.eventName!).child("users").observe(.childAdded) { (userTableSnap) in
            
            let userID = userTableSnap.key
            let userTableDict = userTableSnap.value as? [String: Any]
            
            let userName = userTableDict!["name"] as! String
            let userGoing = userTableDict!["going"] as! Bool
            
            let user = User(nameText: userName, isGoing: userGoing)
            
            self.users.append(user)
            
            print(self.users)
            
            self.userTableView.reloadData()
        }
    }
}

extension EventDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].names
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        userTableView.backgroundColor = .clear
        
        return cell
    }
    
    func setCustomBackImage() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.gray
        
    }
    
    
    
    
}

