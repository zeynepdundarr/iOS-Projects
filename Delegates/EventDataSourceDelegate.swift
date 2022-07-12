//
//  EventDataSourceDelegate.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 20.06.2022.
//

import Foundation

protocol EventDataSourceDelegate{
    func eventListLoaded(eventArr:[Event?])
    func eventLoaded(event: Event?)
    func eventUpdated(documentID: String?)

}



