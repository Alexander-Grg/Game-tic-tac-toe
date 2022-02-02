//
//  GameEndedState.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 20.01.2022.
//

import Foundation

public class GameEndedState: GameState {

    public var isCompleted: Bool = false
    public let winner: Player?
    private (set) weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    public func begin() {
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + "Win"
        } else {
            self.gameViewController?.winnerLabel.text = "Draw"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        Log(.gameFinished(winner: self.winner))
    }

    
    public func addMark(at position: GameboardPosition) { }
    
    public func winnerName(from winner: Player) -> String {
        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        case .computer: return "Compurer has won"
        }
    }
    
     
}
