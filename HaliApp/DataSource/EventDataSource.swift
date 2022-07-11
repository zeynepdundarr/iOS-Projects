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
    
    var delegate : EventDataSourceDelegate?
    @Published var errorMessage: String?
    var event: Event?
    var db: Firestore!
    var eventArr : [Event?] = []
    
    func saveEventData(event: Event?){
        db = Firestore.firestore()

        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: [
            "name": event!.name,
            "hour": event!.hour,
            "pitch_name": event!.pitch_name,
            "attendee_list": event!.attendee_list,
            "player_quota_left": event!.player_quota_left
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
              DispatchQueue.main.async {
                  self.delegate?.eventListLoaded(eventArr:self.eventArr)
              }
          }
        }
    }
    // To update age and favorite color:
    
    func updateEventData(event: Event?){
        
        if event == nil {
            print("Event is nil!")
            return
        }
        
        let documentId = event!.id!
        db = Firestore.firestore()
        print("Globals currentUser in eventDataSource: \(Globals.currentUser)")
        db.collection("events").document(documentId).updateData([
            "attendee_list": FieldValue.arrayUnion([Globals.currentUser]),
            "player_quota_left" : FieldValue.increment(Int64(1))
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated with ID: \(documentId)")
                print("QuerySnapshotListener added.")
            }

        }
    }
    
    func getEventDataWithID(documentID: String) {
        
      db = Firestore.firestore()
      let docRef = db.collection("events").document(documentID)
      print("after update getting the data again")
      docRef.getDocument { document, error in
        if let error = error as NSError? {
          self.errorMessage = "Error getting document: \(error.localizedDescription)"
        }
        else {
          if let document = document {
            do {
                self.event = try document.data(as: Event.self)
                DispatchQueue.main.async {
                    self.delegate?.eventLoaded(event: self.event)
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


