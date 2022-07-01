//
//  EventDetailViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 21.06.2022.
//

import UIKit

class EventDetailViewController: UIViewController, EventDataSourceDelegate, EventDetailDataSourceDelegate{

    
    var event: Event?
    // var ds = Globals.eventDataSource
    var ds = EventDataSource()
    
    let defaultEvent : Event = Event(id: "defaultID", name: "defaultEvent", hour: "1", pitch_name: "p1", attendee_list: ["defaul_player"], player_quota_left : 1100)
    
    @IBOutlet weak var eventHour: UILabel!
    @IBOutlet weak var pitchName: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var attendee_list: UILabel!
    @IBOutlet weak var playerQuotaLeft: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ds.delegate2 = self

        if event != nil {
            eventName.text = self.event!.name
            eventHour.text = self.event!.hour
            pitchName.text = self.event!.pitch_name
            playerQuotaLeft.text = String(self.event!.player_quota_left)
            
            var str = ""
            for i in 0..<(self.event!.attendee_list.count-1) {
                str += (self.event?.attendee_list[i])! + "\n"
            
            attendee_list.text = str
            print("Attendee List: \(str)")
            }
        }
    }
    
    // make event id visible
    @IBAction func AddPlayer(_ sender: Any) {
        print("Add player in EventDetailViewController")
        ds.updateEventData(event: event)
  
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
    func print_attendees_list(event: Event?) -> String{
    
        var str = ""
        for i in 0..<(self.event!.attendee_list.count-1) {
            str += (self.event?.attendee_list[i])! + "\n"
        }
        return str
    }
    
    func eventListLoaded(eventArr: [Event?]) {
        
    }
    
    func eventLoadedDetail(event: Event?) {
        // 1. oncelik bu methoda girsin
        // 2. oncelik UI yenilensin
        print("Alo")
        if event != nil {
            attendee_list.text = print_attendees_list(event:event!)
            playerQuotaLeft.text = String(event!.player_quota_left)
            print("Attention player quota is changed!!!!")
        }else{
            print("Error in event loaded EventDetailViewController.")
        }
    }
    
    func eventUpdated(documentID: String?) {
        print("Event updated method")
        if documentID != nil {
            print("Event updated by click in DetailView controller")
            ds.getEventDataWithID(documentID: documentID!)
        }else{
            print("Error in eventUpdated EventDetailViewController.")
        }
    }
    
    func eventLoaded(event: Event?) {
        
    }
}

