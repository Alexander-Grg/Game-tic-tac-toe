//
//  GameViewController.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 16.01.2022.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var gameboardView: GameBoardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private var moveCount = 0
    private let gameBoard = Gameboard()
    private let gameMode = gameModeSigleton.shared.gameMode
    private lazy var referee = Referee(gameboard: self.gameBoard)
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNames()
        
        self.goToFirstState()
        self.moveCount += 1
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            if self.currentState.isCompleted == false && self.gameMode == .versusComputer {
                self.currentState.addMark(at: position)
                self.moveCount += 1
            } else if self.currentState.isCompleted && self.gameMode == .versusComputer {
                self.goToComputerState()
                self.delay(1.0) { [self] in
                    self.goToFirstState()
                    self.moveCount += 1
                }
            } else if self.currentState.isCompleted == false && self.gameMode == .versusHuman {
                self.currentState.addMark(at: position)
                self.moveCount += 1
            } else if self.currentState.isCompleted && self.gameMode == .versusHuman {
                self.goToNextState()
                self.currentState.addMark(at: position)
                self.moveCount += 1
            }
        }
    }
    
    private func setUpNames() {
        if gameMode == .versusComputer {
            firstPlayerTurnLabel.text = "Human"
            secondPlayerTurnLabel.text = "Computer"
        }
    }
    
    func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
    
    private func goToFirstState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            self.moveCount = 0
            return
        }
        
        if moveCount >= 9 {
            Log(.gameFinished(winner: nil))
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            self.moveCount = 0
        }
        
        let player = Player.first
        self.currentState = PlayerInputState(player: player,
                                             markViewProtorype: player.markViewPrototype,
                                             gameViewController: self,
                                             gameBoard: gameBoard,
                                             gameBoardView: gameboardView)
        
    }
    
    private func goToComputerState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            self.moveCount = 0
            return
        }
        
        if moveCount >= 9 {
            Log(.gameFinished(winner: nil))
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            self.moveCount = 0
        }
        
        let player = Player.second
        self.currentState = ComputerState(player: player,
                                          markViewProtorype: player.markViewPrototype,
                                          gameViewController: self,
                                          gameBoard: gameBoard,
                                          gameBoardView: gameboardView)
        
    }
    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            self.moveCount = 0
            return
        }
        
        if moveCount >= 9 {
            Log(.gameFinished(winner: nil))
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            self.moveCount = 0
        }
        
        
        if let playerInputState = currentState as? PlayerInputState{
            let player = playerInputState.player.next
            self.currentState = PlayerInputState(player: player,
                                                 markViewProtorype: player.markViewPrototype,
                                                 gameViewController: self,
                                                 gameBoard: gameBoard,
                                                 gameBoardView: gameboardView)
        }
        if let playerInputState = currentState as? ComputerState{
            let player = playerInputState.player.next
            self.currentState = ComputerState(player: player,
                                              markViewProtorype: player.markViewPrototype,
                                              gameViewController: self,
                                              gameBoard: gameBoard,
                                              gameBoardView: gameboardView)
            gameModeSigleton.shared.gameStatus = false
            self.goToFirstState()
        }
        
        
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        Log(.restartGame)
        self.gameBoard.clear()
        self.gameboardView.clear()
        gameModeSigleton.shared.gameStatus = false
        self.goToFirstState()
        self.moveCount = 0
    }
    
}



