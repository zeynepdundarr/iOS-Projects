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

class PitchListTableViewController: UITableViewController, PitchDataSourceDelegate{
    var pitch: Pitch?

    var pitchArr: [Pitch?] = [Pitch(pitch_name:"Pitch #1",
                                    capacity: 11,
                                    available_hours: ["17:00 - 18:00","18:00 - 19:00","20:00 - 21:00", "22:00 - 23:00"],
                                    pitch_owner_name: "Ahmet Yilmaz", address: "Zekeriyakoy - Istanbul")]
    
    var TestArr = ["a","b","c"]
    var pitchData :  [String: [Pitch]] = ["data":
        [Pitch(pitch_name:"Pitch #1",
               capacity: 11,
               available_hours: ["17:00 - 18:00","18:00 - 19:00","20:00 - 21:00", "22:00 - 23:00"],
               pitch_owner_name: "Ahmet Yilmaz",
               address: "Zekeriyakoy - Istanbul"),
         Pitch(pitch_name:"Pitch #2",
                capacity: 11,
                available_hours: ["17:00 - 18:00","18:00 - 19:00","20:00 - 21:00", "22:00 - 23:00"],
                pitch_owner_name: "MEhmet Yilmaz",
                address: "Moda - Istanbul"),
         Pitch(pitch_name:"Pitch #3",
                capacity: 11,
                available_hours: ["17:00 - 18:00","18:00 - 19:00","20:00 - 21:00", "22:00 - 23:00"],
                pitch_owner_name: "Salih Yilmaz",
                address: "Besiktas - Istanbul")]]
    
    var ds = PitchDataSource()
    
    @IBOutlet var pitchListTableViewController: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ds.delegate = self
        // later implementation
        // ds.addQuerySnapshotListenerCollection()
        // ds.savePitchData(pitch: pitchData["data"]![1])
        ds.getPitchData()

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pitchDetailSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PitchCell", for: indexPath)
        
        if let pitch = self.pitchArr[indexPath.row]{
            self.pitch = self.pitchArr[indexPath.row]!
            cell.textLabel?.text = self.pitchArr[indexPath.row]?.pitch_name
        }else{
            print("Pitch is empty!")
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // segue başlamadan önce çalışacak fonksiyon
        if segue.identifier == "pitchDetailSegue"{
            let detailViewController = segue.destination as! PitchDateDetailViewController
            if self.pitch != nil {
                detailViewController.pitch = self.pitch
            }else{
                print("Clicked event is nil!")
            }
        }}
    
    //delegate methods
    func pitchListLoaded(pitchArr: [Pitch?]) {
        print("View Controller - pitch List in Loaded")
        self.pitchArr = pitchArr
        self.pitchListTableViewController.reloadData()
    }
    
    @IBAction func getPitchListOnClick(_ sender: Any) {
        print("CLICK - save pitch: ")
        ds.savePitchData(pitch: pitchData["data"]![2])
    }
    
    func pitchListUpdated(){
        ds.getPitchData()
       
    }
    
    func pitchDetailLoaded(pitch: Pitch?) {
        print("Oops! wrong place!")
    }

}
