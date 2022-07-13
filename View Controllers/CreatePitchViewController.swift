//
//  CreatePitchViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 13.07.2022.
//

import UIKit


class CreatePitchViewController: UIViewController {

    @IBOutlet weak var pitch_name: UIStackView!
    @IBOutlet weak var capacity: UIStackView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var available_hours_and_date: UIStackView!
    
    @IBOutlet weak var pitch_owner_name: UIStackView!
    @IBOutlet weak var hour: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var dateChosen: UILabel!
    
    
    var available_hour_and_date : [String: [String]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateChosen.text = dateFormatter.string(from: datePicker.date)
        
    }

    func getPitchFields(pitch_name: String, capacity:String, available_date_and_hours:[String: [String]], pitch_owner_name: String, address:String){
        
    }
    
    @IBAction func dateSelectedFromDatePicker(_ : AnyObject){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateChosen.text = dateFormatter.string(from: datePicker.date)
        
        
        
    }
    
    
}
