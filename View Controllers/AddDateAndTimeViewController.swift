//
//  AddDateAndTimeViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 13.07.2022.
//

import UIKit

class AddDateAndTimeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var hourField: UITextField!
    @IBOutlet weak var addHourButton: UIButton!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var chosenDateAndTime: UILabel!
    
    var selectedInterval: String?
    var selectedDate: String?
    var available_hour_and_date : [String: [String]]?
    var date: Date?
    var slotInterval: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        
        chosenDateAndTime.text = dateFormatter.string(from: DatePicker.date)
        addHourButton.titleLabel!.text = "Add Slot"
    
    }
    
    @IBAction func dateSelectedFromDatePicker(_ : AnyObject){
        formatSlot(date: DatePicker.date)
    }
    
    @IBAction func enterSlotButton(_ sender: Any) {
        chosenDateAndTime.text = self.slotInterval
        print("enterSlotButton - SLOT ADDED: \(self.slotInterval)")
    }
    
    func formatSlot(date: Date){
        
        self.date = DatePicker.date
        let interval = 3600
        let dateInterval = DateInterval(start:self.date!, duration:TimeInterval(interval))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        
        let startStr = dateFormatter.string(from: dateInterval.start)
        let endStr = dateFormatter.string(from: dateInterval.end)
        
        let startStrSplit = startStr.components(separatedBy: " ")
        let endStrSplit = endStr.components(separatedBy: " ")
        
        let date = startStrSplit[0]
        let startHour = startStrSplit[1]
        let endHour = endStrSplit[1]
        
        let slotInterval = "\(startHour)" + " - " + "\(endHour)"
    
        let key = date
        
        if let available_hour_and_date = self.available_hour_and_date{
            
        }
        
        if self.available_hour_and_date!.keys.contains(key){
            self.available_hour_and_date![date]!.append(slotInterval)
        }else{
            var hoursArr : [String] = []
            hoursArr.append(slotInterval)
            self.available_hour_and_date![date] = hoursArr
        }
        self.slotInterval = slotInterval
    }
    
    func getPitchFields(pitch_name: String, capacity:String, available_date_and_hours:[String: [String]], pitch_owner_name: String, address:String){
        
    }
    
    
    
    
}
