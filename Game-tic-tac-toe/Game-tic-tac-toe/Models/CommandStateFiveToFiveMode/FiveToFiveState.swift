//
//  FiveToFiveState.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 25.01.2022.
//

import Foundation

class FiveToFiveState: GameState {
    
    public let markViewPrototype: MarkView
    public let player: Player
    var MoveCounter = 0
    var isCompleted: Bool = false
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameBoardView?
    
    init(player: Player, gameViewController: GameViewController,
         gameBoard: Gameboard, gameBoardView: GameBoardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second, .computer:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        Log(action: .playerSetMark(player: player, position: position))
        
        guard let gameBoardView = gameBoardView,
              gameBoardView.canPlaceMarkView(at: position) else {
                  return
              }
        
        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        
        if player == .first {
            gameModeSigleton.shared.numberOfMovesPlayer1.append(PlayerMove(player: .first, position: position))
        } else {
            gameModeSigleton.shared.numberOfMovesPlayer2.append(PlayerMove(player: .second, position: position))
        }
        
        MoveCounter += 1
        if MoveCounter >= 5 { isCompleted = true }
    }
}
