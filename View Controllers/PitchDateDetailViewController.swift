//
//  PitchDateDetailViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 12.07.2022.
//

import UIKit
class PitchDateDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PitchDataSourceDelegate {

    @IBOutlet weak var button: UIButton!
    var available_hours: [String] = []
    var pitch: Pitch?
    var ds = PitchDataSource()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var DateLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        ds.delegate = self

        if let pitch = pitch{
            self.available_hours = pitch.available_date_and_hours
            ds.addQuerySnapshotListenerCollection(documentID: pitch.id)
        }else{
            print("Pitch is empty!")
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        DateLabel.text = dateFormatter.string(from: DatePicker.date)
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        let reservedSlot = self.available_hours[indexPath.row]
         ds.removeSlotAndUpdatePitch(documentID: self.pitch!.id!, reservedSlot: reservedSlot)
     }
    
    @IBAction func dateSelectedFromDatePicker(_ : AnyObject){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        DateLabel.text = dateFormatter.string(from: DatePicker.date)
    }
    
    // delegate
    func pitchListLoaded(pitchArr: [Pitch?]) {
        
    }
    
    func pitchListUpdated() {
        
    }
    
    func pitchDetailLoaded(pitch: Pitch?){
        print("PitchDateDetailViewController - pitch is: \(pitch)")
        print("PitchDateDetailViewController - new available_hours: \(pitch!.available_date_and_hours)")
        self.available_hours = pitch!.available_date_and_hours
        tableView.reloadData()
    }

    @IBAction func addSlotButtonClicked(_ sender: Any) {
        
        if let pitch = self.pitch{
            ds.addSlotAndUpdatePitch(documentID: self.pitch!.id!, newSlot: "23:00 - 24:00")
        }
    }
    
}


