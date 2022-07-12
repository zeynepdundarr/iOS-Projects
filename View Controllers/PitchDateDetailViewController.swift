//
//  PitchDateDetailViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 12.07.2022.
//

import UIKit
class PitchDateDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PitchDataSourceDelegate {

    
    
    var available_hours: [String] = []
    var pitch: Pitch?
    var ds = PitchDataSource()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var DateLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pitch = pitch{
            self.available_hours = pitch.available_hours
            print("PitchDateDetailViewController :Available Hours!")
        }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        DateLabel.text = dateFormatter.string(from: DatePicker.date)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return available_hours.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableHoursCell", for: indexPath)
        cell.textLabel?.text = self.available_hours[indexPath.row]
         print("Available hours: ", self.available_hours[indexPath.row])
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This row is selected!")
        var ds = PitchDataSource()
         
        ds.updatePitchData(pitch: self.pitch, reservedSlot: "17:00 - 18:00")    }
    
    
    @IBAction func dateSelectedFromDatePicker(_ : AnyObject){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        DateLabel.text = dateFormatter.string(from: DatePicker.date)
        print("A date is selected")
        print("And removing from pitch_id: \(self.pitch!.id)")
        print("Removing slots: 17:00 - 18:00")

    }
    
 
    
    // delegate
    func pitchListLoaded(pitchArr: [Pitch?]) {
        
    }
    
    func pitchListUpdated() {
        
    }
    
    func pitchDetailLoaded(pitch: Pitch?){
        self.available_hours = pitch!.available_hours
        tableView.reloadData()
    }
    
}


