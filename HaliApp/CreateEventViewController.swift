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

class CreateEventViewController: UIViewController{
    
    var ds = DataSource()
    var event: Event?
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        //saveEvent()
       
        ds.delegate = self
        ds.getEventData()
        
    }
    
// save an evet to database
    
    func saveEvent(){
        
        db = Firestore.firestore()
        print("db.description: \(db.description)")
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: [
            "name": "Event #3",
            "hour": "18:00 - 19:00",
            "pitch_name": "Moda Stadyumu"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CreateEventViewController: EventDataSourceDelagate{
    func eventLoaded(event: Event?) {
        print("View Controller - event List in Loaded")
        self.event = event
        print("event: \(self.event!)")
    }

}

