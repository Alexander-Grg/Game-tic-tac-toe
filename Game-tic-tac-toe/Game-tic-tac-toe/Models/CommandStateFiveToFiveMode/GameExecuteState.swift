//
//  GameExecuteState.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 25.01.2022.
//

import Foundation

class GameExecuteState: GameState {
    
    var isCompleted: Bool = false
    var player: Player = .first
    var completionHandler: () -> Void
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameBoardView?
    private var timer: Timer?
    
    init(gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameBoardView, _ completionHandler: @escaping () -> Void) {
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.completionHandler = completionHandler
    }
    
    @objc func toMakeMove() {
        if gameModeSigleton.shared.numberOfMovesPlayer1.count > 0 || gameModeSigleton.shared.numberOfMovesPlayer2.count > 0 {
            var move: PlayerMove?
            
            if player == .first {
                move = gameModeSigleton.shared.numberOfMovesPlayer1.removeFirst()
                gameViewController?.firstPlayerTurnLabel.isHidden = false
                gameViewController?.secondPlayerTurnLabel.isHidden = true
                
            } else {
                move = gameModeSigleton.shared.numberOfMovesPlayer2.removeFirst()
                gameViewController?.firstPlayerTurnLabel.isHidden = true
                gameViewController?.secondPlayerTurnLabel.isHidden = false
            }
            
            if let move = move {
                addMark(at: move.position)
                player = player.next
            }
            
        } else {
            timer?.invalidate()
            completionHandler()
        }
    }
    
    func begin() {
        timer = Timer.scheduledTimer(timeInterval: 0.75,
                                     target: self,
                                     selector: #selector(toMakeMove),
                                     userInfo: nil, repeats: true)
    }
    
    func addMark(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView else { return }
        
        gameBoard?.setPlayer(player, at: position)
        
        if !gameBoardView.canPlaceMarkView(at: position) {
            gameBoardView.removeMarkView(at: position)
        }
        
        gameBoardView.placeMarkView(player.markViewPrototype.copy(), at: position)
    }
}
