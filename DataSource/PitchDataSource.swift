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

    func addQuerySnapshotListenerCollection(pitch: Pitch?){
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
        DispatchQueue.main.async {
            // TODO: get a pitch by doc id
            print("addQuerySnapshotListenerCollection passes to delegate!")
         self.delegate?.pitchDetailLoaded(pitch:self.pitch)
            }
        }else{
            print("Pitches can not be updated!")
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
              //print("Get pitch data - pitchArray: \(self.pitchArr)")
              DispatchQueue.main.async {
                  self.delegate?.pitchListLoaded(pitchArr:self.pitchArr)
              }
          }
        }
    }
       
    func updatePitchData(pitch: Pitch?, reservedSlot: String){
        
        if pitch == nil {
            print("Pitch is nil!")
            return
        }
    
        let documentId = pitch!.id!
        let db = Firestore.firestore()
        db.collection("pitches").document(documentId).updateData([
            "available_hours": FieldValue.arrayRemove([reservedSlot])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated with ID: \(documentId)")
            }

        }
    }
    
// TO DO
//    func getPitchData2() {
//
//      db = Firestore.firestore()
//      db.collection("pitches").addSnapshotListener { (querySnapshot, error) in
//        guard let documents = querySnapshot?.documents else {
//            print("No documents")
//          return
//        }
//        self.pitchArr = documents.compactMap { queryDocumentSnapshot -> Pitch in
//            return try queryDocumentSnapshot.data(as: Pitch.self)
//        }
//      }
//    }
}


