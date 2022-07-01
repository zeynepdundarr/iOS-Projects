//
//  SignupViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 17.06.2022.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let email = "ealtintas17@ku.edu.tr"
        let password = "Hoppala1998"
        Globals.currentUser = "Ali Sutcu"
        signup(email: email, password: password)
    }
    

    func signup(email:String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
          guard let strongSelf = self else {
            return
              
          }
            guard error == nil else {
                print("Error in Signup!")
                // TODO: enter signup button
                return
            }
            print("Error in Login!")
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
