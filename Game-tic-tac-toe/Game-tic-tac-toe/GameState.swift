//
//  GameState.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 20.01.2022.
//

import Foundation

public protocol GameState {
    
    var isCompleted: Bool { get }
    
    func begin()
    
    func addMark(at position: GameboardPosition)
    
}

public class PlayerInputState: GameState {

    
    
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
        guard let gameboardView = self.gameBoardView,
              gameboardView.canPlaceMarkView(at: position) else { return }
        self.gameBoard?.setPlayer(self.player, at: position)
        self.gameBoardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
        Log(.playerInput(player: self.player, position: position))
    }
}


