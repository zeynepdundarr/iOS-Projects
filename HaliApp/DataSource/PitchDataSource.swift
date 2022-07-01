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
    
    var delegate : PitchDataSourceDelagate?
    @Published var errorMessage: String?
    var pitch: Pitch?
    var db: Firestore!
    var pitchArr : [Pitch?] = []
 
    func savePitchData(){
        db = Firestore.firestore()
        print("db.description: \(db.description)")
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("pitches").addDocument(data: [
            "pitch_name": "Sariyer Stadyumu",
            "capacity": "11",
            "available_hours": "13:00 - 14:00",
            "pitch_owner_name": "Hasan Yilmaz",
            "address": "Sariyer/Istanbul"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
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
              print("pitchArray: \(self.pitchArr)")
              DispatchQueue.main.async {
                  self.delegate?.pitchListLoaded(pitchArr:self.pitchArr)
              }
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


