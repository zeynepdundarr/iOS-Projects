//
//  EventDetailViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 21.06.2022.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event: Event? = nil
    
    @IBOutlet weak var eventName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello Detail View Controller")
        print("segue event: \(self.event)")
        eventName.text = self.event!.name
        // Do any additional setup after loading the view.
    }
        
        // Fetching data with document id
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
   
}
