//
//  Event.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 20.06.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Event: Codable{
    
    @DocumentID var id: String?
    var name: String
    var hour: String
    var pitch_name: String
    var attendee_list: [String]
    var player_quota_left : Int
}
