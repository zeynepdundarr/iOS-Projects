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


    var pitchArr: [Pitch?] = []
    var TestArr = ["a","b","c"]
    var ds = PitchDataSource()
    
    @IBOutlet var pitchListTableViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ds.delegate = self
        //ds.savePitchData()
        ds.getPitchData()
   
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TestArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PitchCell", for: indexPath)

//        cell.textLabel?.text = self.pitchArr[indexPath.row]!.pitch_name
        cell.textLabel?.text = self.TestArr[indexPath.row]

        return cell
    }
    
    //delegate methods
    func pitchListLoaded(pitchArr: [Pitch?]) {
        print("View Controller - pitch List in Loaded")
        self.pitchArr = pitchArr
        print("pitchArr: \(self.pitchArr)")
        self.pitchListTableViewController.reloadData()
    }
    
}
