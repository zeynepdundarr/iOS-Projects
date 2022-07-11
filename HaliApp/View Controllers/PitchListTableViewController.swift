//
//  PitchListTableViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 21.06.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PitchListTableViewController: UITableViewController, PitchDataSourceDelagate{


    var pitchArr: [Pitch?] = [Pitch(pitch_name:"Pitch #1",
                                    capacity: 11,
                                    available_hours: "17:00 - 18:00",
                                    pitch_owner_name: "Ahmet Yilmaz", address: "Zekeriyakoy - Istanbul")]
    
    var TestArr = ["a","b","c"]
    var pitchData :  [String: [Pitch]] = ["data":
        [Pitch(pitch_name:"Pitch #1",
               capacity: 11,
               available_hours: "17:00 - 18:00",
               pitch_owner_name: "Ahmet Yilmaz",
               address: "Zekeriyakoy - Istanbul"),
         Pitch(pitch_name:"Pitch #2",
                capacity: 11,
                available_hours: "16:00 - 17:00",
                pitch_owner_name: "MEhmet Yilmaz",
                address: "Moda - Istanbul"),
         Pitch(pitch_name:"Pitch #3",
                capacity: 11,
                available_hours: "16:00 - 17:00",
                pitch_owner_name: "Salih Yilmaz",
                address: "Besiktas - Istanbul")]]
    
    var ds = PitchDataSource()
    
    @IBOutlet var pitchListTableViewController: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ds.delegate = self
        // later implementation
        // ds.addQuerySnapshotListenerCollection()
        //ds.savePitchData(pitch: pitchData["data"]![1])

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pitchArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PitchCell", for: indexPath)

//        cell.textLabel?.text = self.pitchArr[indexPath.row]!.pitch_name
        cell.textLabel?.text = self.pitchArr[indexPath.row]?.pitch_name
        return cell
    }
    
    //delegate methods
    func pitchListLoaded(pitchArr: [Pitch?]) {
        print("View Controller - pitch List in Loaded")
        self.pitchArr = pitchArr
        print("pitchArr: \(self.pitchArr)")
        self.pitchListTableViewController.reloadData()
    }
    
    @IBAction func getPitchListOnClick(_ sender: Any) {
        print("CLICK - save pitch: ")
        ds.savePitchData(pitch: pitchData["data"]![2])
    }
    
    func pitchListUpdated(){
        ds.getPitchData()
       
    }
    
   
}
