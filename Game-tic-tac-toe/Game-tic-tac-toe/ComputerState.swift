//
//  ComputerState.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 21.01.2022.
//

import Foundation


public class ComputerState: GameState {
    
    
    public let player: Player
    public let markViewPrototype: MarkView
    public var isCompleted: Bool = false
    private (set) weak var gameViewController: GameViewController?
    private (set) weak var gameBoard: Gameboard?
    private (set) weak var gameBoardView: GameBoardView?
    
    init(player: Player, markViewProtorype: MarkView, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameBoardView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewProtorype
    }
    
    public func begin() {
        
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
            
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
   
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView,
              let position2 = randomPositions(),
              gameBoardView.canPlaceMarkView(at: position2)
        else { return }
        gameBoardView.placeMarkView(self.markViewPrototype.copy(), at: position2)
        self.isCompleted = true
        gameModeSigleton.shared.isComputerStateActive = true
        Log(.playerInput(player: self.player, position: position2))
      
    }
    
    
    
    public func randomPositions() -> GameboardPosition? {
        var arrayOfPositions: [GameboardPosition] = []
        guard let gameBoardView = gameBoardView else {
            return GameboardPosition(column: 0, row: 0)
        }
        for column in 0...GameboardSize.columns - 1 {
            for row in 0...GameboardSize.rows - 1 {
                let position = GameboardPosition(column: column, row: row)
                if gameBoardView.canPlaceMarkView(at: position) {
                    arrayOfPositions.append(position)
                }
            }
        }
        return arrayOfPositions.randomElement()
    }
}
