//
//  LoginViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 17.06.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let email = "ealtintas17@ku.edu.tr"
        let password = "Hoppala1998"
        login(email: email, password: password)
       
    }
    
    func login(email: String, password: String){
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
          guard let strongSelf = self else {
            
            return
              
          }
            guard error == nil else {
                print("Error in Login!")
                return
            }
            print("You are logged in!")
            print("Logged account:  \(email)")
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
