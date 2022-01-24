//
//  Player.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 16.01.2022.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case computer
    
    
    
    var next: Player {
        switch self {
        case .first: return gameModeSigleton.shared.gameMode == .versusComputer ? .computer: Player.second
        case .second: return .first
        case .computer: return .first
        }
    }

    
    var markViewPrototype: MarkView {
        switch self {
        case .first: return Xview()
        case .second, .computer: return Oview()
        }
    }
}
