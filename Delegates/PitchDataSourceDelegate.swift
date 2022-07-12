//
//  PitchDataSourceDelegate.swift
//  HaliApp
//
//  Created by Zeynep Dundar on 21.06.2022.
//

import Foundation

protocol PitchDataSourceDelegate{
    func pitchListLoaded(pitchArr:[Pitch?])
    func pitchListUpdated()
    func pitchDetailLoaded(pitch: Pitch?)
}

