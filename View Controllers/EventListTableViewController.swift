//
//  TableViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 20.06.2022.
//

import UIKit
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class EventListTableViewController: UITableViewController, EventDataSourceDelegate{


    var eventArr : [Event?] = []
    var ds = EventDataSource()
    var ds2 = EventListenerDataSource()
    var eb = EventBrain()
    var event: Event?
    var db: Firestore!
    
    @IBOutlet var eventListTableViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var eventData :  [String: [Event]] =
        ["data":
            [Event(name:"Event #1",
                  hour: "17:00 - 18:00",
                  pitch_name: "Moda Stadyumu",
                  attendee_list: ["Ahmet Yilmaz", "Mehmet Yilmaz", "Cem Yilmaz"],
                  player_quota_left: 11),
             Event(name:"Event #2",
                   hour: "17:00 - 18:00",
                   pitch_name: "Kadikoy Stadyumu",
                   attendee_list: ["Ceren Aksu"],
                   player_quota_left: 11)]
            ]

        ds.delegate = self
        Globals.currentUser = "Fatima"
        //ds.saveEventData(event: eventData["data"]![0])
        ds.getEventData()
      
   
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell.textLabel?.text = self.eventArr[indexPath.row]!.name
        self.event = self.eventArr[indexPath.row]!

        return cell
    }
    
    //delegate methods
    func eventListLoaded(eventArr: [Event?]) {
        self.eventArr = eventArr
        self.eventListTableViewController.reloadData()
    }
    
    func eventLoaded(event: Event?){
        print("Hello Table view delegate is called!")
        self.event = event

    }
    
    func eventUpdated(documentID: String?) {
        
    }
    
    func eventLoadedDetail(event: Event?) {
        
    }
    
    // performSegue(withIdentifier: "DetailSegue", sender: nil)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // segue başlamadan önce çalışacak fonksiyon
        if segue.identifier == "eventDetailSegue"{
            let detailViewController = segue.destination as! EventDetailViewController
            if self.event != nil {
                detailViewController.event = self.event!
            }else{
                print("Clicked event is nil!")
            }
        }}
        
    
    @IBAction func eventCellClick(_ sender: Any) {
        performSegue(withIdentifier: "eventDetailSegue", sender: nil)
    }
   
}
