//
//  Pitch.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 21.06.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Pitch: Codable{
    
    @DocumentID var id: String?
    
    var pitch_name: String
    var capacity: Int
    var available_hours: String
    var pitch_owner_name: String
    var address: String
    
}
