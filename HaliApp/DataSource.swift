//
//  DataSource.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 20.06.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class DataSource{
    
    var delegate : EventDataSourceDelagate?
    @Published var errorMessage: String?
    
    var event: Event?
    var db: Firestore!

    
    func getEventData(){
        db = Firestore.firestore()
        db.collection("events").getDocuments() { (querySnapshot, err) in
            print("QuerySnapshot: \(querySnapshot!)")
            if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                   
                    for document in querySnapshot!.documents {
                        self.fetchEvent(documentId: document.documentID)
                    }
            
                }
        }
    }
    
    func fetchEvent(documentId: String) {
        
      let docRef = db.collection("events").document(documentId)
        docRef.getDocument { document, error in
        if let error = error as NSError? {
          self.errorMessage = "Error getting document: \(error.localizedDescription)"
        }
        else {
          if let document = document {
            do {
              self.event = try document.data(as: Event.self)
           
              DispatchQueue.main.async {
                  self.delegate?.eventLoaded(event:self.event)
                    
              }
            }
            catch {
              print(error)
            }
          }
        }
      }
    }
}


