//
//  CreateEventViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 17.06.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class EventViewController: UIViewController{
  
    
    var eventArr : [Event?] = []
    var ds = EventDataSource()
    var event: Event?
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ds.delegate = self
        //ds.saveEventData()
        ds.getEventData()

    }
}

extension EventViewController: EventDataSourceDelagate{
    func eventListLoaded(eventArr: [Event?]) {
        print("View Controller - event List in Loaded")
        self.eventArr = eventArr
        print("eventArr: \(self.eventArr)")
    }
}

//create a segue

