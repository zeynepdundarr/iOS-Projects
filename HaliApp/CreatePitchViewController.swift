//
//  CreatePitchViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 19.06.2022.
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UIKit

class CreatePitchViewController: UIViewController {
    
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        savePitch()
 
    }
    
    func savePitch(){
        
        db = Firestore.firestore()
        print("db.description: \(db.description)")
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("pitches").addDocument(data: [
            "pitch_name": "Yusuf Ziya Öniş",
            "pitch_owner_name" : "Ahmet Yılmaz",
            "available_hours": "18:00 - 19:00",
            "price": 300,
            "address" : "Sariyer - Istanbul",
            
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
