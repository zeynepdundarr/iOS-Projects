//
//  DataSource.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 20.06.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class EventDataSource{
    
    var delegate : EventDataSourceDelagate?
    @Published var errorMessage: String?
    var event: Event?
    var db: Firestore!
    var eventArr : [Event?] = []
    
    func saveEventData(){
        db = Firestore.firestore()
        print("db.description: \(db.description)")
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: [
            "name": "Event #4",
            "hour": "18:00 - 19:00",
            "pitch_name": "Kadikoy Stadyumu"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    func getEventData(){
        
        db = Firestore.firestore()
        db.collection("events").getDocuments { (snapshot, error) in
          if let error = error {
            print(error)
          } else if let snapshot = snapshot {

              self.eventArr = snapshot.documents.compactMap {
              return try? $0.data(as: Event.self)
            }
              print("EventArray: \(self.eventArr)")
              DispatchQueue.main.async {
                  self.delegate?.eventListLoaded(eventArr:self.eventArr)
              }
          }
        }
    }
    
    func getEventDataWithID(documentId: String) {
        
      db = Firestore.firestore()
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


