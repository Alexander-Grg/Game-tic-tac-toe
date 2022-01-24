//
//  LogCommand.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 20.01.2022.
//

import Foundation

final class LogCommand {
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch self.action {
        case .playerInput(player: let player, position: let position):
            return "\(player) placed mark at \(position)"
        case .gameFinished(let winner):
            if let winner = winner {
                return "\(winner) win game"
            } else {
                return "game finished with draw"
            }
        case .restartGame:
            return "game restarted"
        }
    }
}
