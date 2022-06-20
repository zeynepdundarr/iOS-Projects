//
//  PitchListViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 19.06.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PitchListViewController: UIViewController {
    
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        readPitches()
        // Do any additional setup after loading the view.
    }
    
    func readPitches(){
        
        db = Firestore.firestore()
        db.collection("pitches").getDocuments() { (querySnapshot, err) in
            print("QuerySnapshot: \(querySnapshot!)")
            if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                   
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
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
