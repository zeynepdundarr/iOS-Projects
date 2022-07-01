//
//  EventBrain.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 22.06.2022.
//

import Foundation
import GameKit

class EventBrain {
    
    var ds = EventDataSource()
    var event : Event?
    var Test: [Int] = []
    
    func addPlayerToEvent(player_name: String, eventID: String){
        ds.getEventDataWithID(documentID: eventID)
    }

}

