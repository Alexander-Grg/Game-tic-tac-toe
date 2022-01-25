//
//  GameState.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 24.01.2022.
//

import Foundation

enum GameMode {
    case versusComputer
    case versusHuman
    case fiveByFive
}

public protocol GameState {
    
    var isCompleted: Bool { get }
    
    func begin()
    
    func addMark(at position: GameboardPosition)
}


