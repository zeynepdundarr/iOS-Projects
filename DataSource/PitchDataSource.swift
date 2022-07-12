//
//  PitchDataSource.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 21.06.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class PitchDataSource{
    
    var delegate : PitchDataSourceDelegate?
    @Published var errorMessage: String?
    var pitch: Pitch?
    var db: Firestore!
    var pitchArr : [Pitch?] = []

    func addQuerySnapshotListenerCollection(documentID: String? = nil){
        print("In addQuerySnapshotListenerCollection")
        db = Firestore.firestore()
        db.collection("pitches").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
        let pitches = documents.compactMap{ queryDocumentSnapshot -> Pitch? in
            return try? queryDocumentSnapshot.data(as: Pitch.self)
         }
        if pitches != nil  {
            print("Query snapshot update detected, transferring modified pitch!")
            self.getPitchDataWithID(documentID: documentID!)
        }
      }
    }
    
    
    
    func savePitchData(pitch: Pitch?){
        db = Firestore.firestore()
        print("db.description: \(db.description)")
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        if let pitch = pitch {
            ref = db.collection("pitches").addDocument(data: [
                "pitch_name": pitch.pitch_name,
                "capacity": pitch.capacity,
                "available_hours": pitch.available_hours,
                "pitch_owner_name": pitch.pitch_owner_name,
                "address": pitch.address
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    DispatchQueue.main.async {
                        self.delegate?.pitchListUpdated()
                    }
                }
            }
        }else{
            print("Pitch is empty!")
        }
        
    }

    func getPitchData(){
        db = Firestore.firestore()
        db.collection("pitches").getDocuments { (snapshot, error) in
          if let error = error {
            print(error)
          } else if let snapshot = snapshot {
     
              self.pitchArr = snapshot.documents.compactMap {
              return try? $0.data(as: Pitch.self)
            }
              DispatchQueue.main.async {
                  self.delegate?.pitchListLoaded(pitchArr:self.pitchArr)
              }
          }
        }
    }
       
    func removeSlotAndUpdatePitch(documentID: String, reservedSlot: String){
        
        if documentID == nil {
            print("Pitch is nil!")
            return
        }
        let db = Firestore.firestore()
        db.collection("pitches").document(documentID).updateData([
            "available_hours": FieldValue.arrayRemove([reservedSlot])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated with ID: \(documentID)")
            }

        }
    }
    
    func getPitchDataWithID(documentID: String) {
        
      db = Firestore.firestore()
      let docRef = db.collection("pitches").document(documentID)
      docRef.getDocument { document, error in
        if let error = error as NSError? {
          self.errorMessage = "Error getting document: \(error.localizedDescription)"
        }
        else {
          if let document = document {
            do {
                self.pitch = try document.data(as: Pitch.self)
                DispatchQueue.main.async {
                    print("getPitchDataWithID is successful!")
                    self.delegate?.pitchDetailLoaded(pitch: self.pitch)
                }
            }
            catch {
              print(error)
            }
          }
        }
      }
    }
    
    func addSlotAndUpdatePitch(documentID: String, newSlot: String){
        if documentID == nil {
            print("Pitch is nil!")
            return
        }
        let db = Firestore.firestore()
        db.collection("pitches").document(documentID).updateData([
            "available_hours": FieldValue.arrayUnion([newSlot])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated with ID: \(documentID)")
            }

        }
    }
}


