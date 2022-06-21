//
//  EventDataSourceDelegate.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 20.06.2022.
//

import Foundation

protocol EventDataSourceDelagate{
    func eventListLoaded(eventArr:[Event?])
    func eventLoaded(event: Event?)
}

