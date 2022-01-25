//
//  Action.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 25.01.2022.
//

import Foundation

public enum gameAction {
    
    case playerSetMark(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}
