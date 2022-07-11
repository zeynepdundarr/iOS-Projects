//
//  EventBrain2.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 2.07.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class EventListenerDataSource {
    
    var delegate: EventDetailDataSourceDelegate?
    var db: Firestore!
    var event: Event?
    var eventArr: [Event?] = []
    func addQuerySnapshotListener(documentID: String){
        
        db = Firestore.firestore()
        db.collection("events").document(documentID)
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
            
              do {
                  self.event = try document.data(as: Event.self)
                  print("EventListenerDataSource attendee list: \(self.event?.attendee_list)")
                  DispatchQueue.main.async {
                      self.delegate?.eventLoadedDetail(event2: self.event)
                  }
              }
              catch {
                print(error)
              }
                
        }
    }
}
