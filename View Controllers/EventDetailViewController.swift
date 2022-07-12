//
//  EventDetailViewController.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 21.06.2022.
//

import UIKit

class EventDetailViewController: UIViewController, EventDetailDataSourceDelegate{

    
    var event: Event?
    // var ds = Globals.eventDataSource
    var ds = EventDataSource()
    var ds2 = EventListenerDataSource()
    
    let defaultEvent : Event = Event(id: "defaultID", name: "defaultEvent", hour: "1", pitch_name: "p1", attendee_list: ["defaul_player"], player_quota_left : 1100)
    
    @IBOutlet weak var eventHour: UILabel!
    @IBOutlet weak var pitchName: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var attendee_list: UILabel!
    @IBOutlet weak var attendee_list_text_view: UITextView!
    @IBOutlet weak var playerQuotaLeft: UILabel!
    
    @IBOutlet weak var attendee_list_text: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ds2.delegate = self
        // no need?
        ds2.addQuerySnapshotListener(documentID: "8VUqSxq6qJ6P7gwEwVRU")
        
        if event != nil {
            eventName.text = self.event!.name
            eventHour.text = self.event!.hour
            pitchName.text = self.event!.pitch_name
            playerQuotaLeft.text = String(self.event!.player_quota_left)
            attendee_list_text_view.text = get_attendees_list(event: event!)
            }
    }
    
    @IBAction func AddPlayer(_ sender: Any) {
        print("Add player in EventDetailViewController")
        ds.updateEventData(event: self.event)
    }

    func get_attendees_list(event: Event) -> String{
        
        var str = ""
        for i in 0..<(event.attendee_list.count) {
            //print("get_attendees_list: \(self.event!.attendee_list[i])")
            str += (event.attendee_list[i]) + "\n"
        }
        print("get_attendees_list str: \(str)")
        return str
    }
    
    func eventListLoaded(eventArr: [Event?]) {
        
    }
    
    func eventLoadedDetail(event2: Event?) {
        
        print("EventDetailViewController is called")
        if event2 != nil {
            
            self.event = event2!
            
            attendee_list_text_view.text = get_attendees_list(event:event2!)
        
            print("EventDetailViewController - attendee_list.text: \(attendee_list_text_view.text!)")
            playerQuotaLeft.text = String(event2!.player_quota_left)
            print("EventDetailViewController - player quota left: \(playerQuotaLeft.text)")
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

