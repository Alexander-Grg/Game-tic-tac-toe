//
//  GameViewController.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 16.01.2022.
//

import UIKit

class GameViewController: UIViewController {
    @IBAction func restartButtonTapped(_ sender: Any) {
        Log(.restartGame)
        self.gameBoard.clear()
        self.gameboardView.clear()
        gameModeSigleton.shared.gameStatus = false
        gameModeSigleton.shared.numberOfMovesPlayer1 = []
        gameModeSigleton.shared.numberOfMovesPlayer2 = []
        self.goToFirstState()
        self.moveCount = 0
    }
    @IBOutlet var gameboardView: GameBoardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    private let gameBoard = Gameboard()
    private let gameMode = gameModeSigleton.shared.gameMode
    private lazy var referee = Referee(gameboard: self.gameBoard)
    private var moveCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNames()
        
        self.goToFirstState()
        self.moveCount += 1
        onSelectScreen()
        
    }
    
    private func onSelectScreen() {
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
            } else if self.currentState.isCompleted == false && self.gameMode == .fiveByFive  {
                self.currentState.addMark(at: position)
            } else if self.currentState.isCompleted && self.gameMode == .fiveByFive {
                self.delay(0.5) { [self] in
                    self.gameBoard.clear()
                    self.gameboardView.clear()
                    self.goToNextState()
                }
            }
        }
    }
    
    private func setUpNames() {
        if gameMode == .versusComputer {
            firstPlayerTurnLabel.text = "Human"
            secondPlayerTurnLabel.text = "Computer"
        }
    }
    
    private func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    private func goToFirstState() {
        let player = Player.first
        
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
        
        if gameMode == .fiveByFive {
            
            self.currentState = FiveToFiveState(player: player,
                                                gameViewController: self,
                                                gameBoard: gameBoard,
                                                gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        } else {
            
            
            self.currentState = PlayerInputState(player: player,
                                                 markViewProtorype: player.markViewPrototype,
                                                 gameViewController: self,
                                                 gameBoard: gameBoard,
                                                 gameBoardView: gameboardView)
        }
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
        
        if gameMode == .fiveByFive && checkIfGameIsComplete() {
            currentState = GameExecuteState(gameViewController: self,
                                            gameBoard: gameBoard,
                                            gameBoardView: gameboardView) { [self] in
                if let winner = referee.determineWinner() {
                    Log(action: .gameFinished(winner: winner))
                    currentState = GameEndedState(winner: winner, gameViewController: self)
                } else {
                    Log(action: .gameFinished(winner: nil))
                    currentState = GameEndedState(winner: nil, gameViewController: self)
                }
            }
            return
        }
        
        if gameMode == .fiveByFive, let playerInputState = currentState as? FiveToFiveState {
            let player = playerInputState.player.next
            currentState = FiveToFiveState(player: player,
                                           gameViewController: self,
                                           gameBoard: gameBoard,
                                           gameBoardView: gameboardView,
                                           markViewPrototype: player.markViewPrototype)
        }
    }
    
    private func checkIfGameIsComplete() -> Bool {
        return gameModeSigleton.shared.numberOfMovesPlayer1.count > 0 && gameModeSigleton.shared.numberOfMovesPlayer2.count > 0
    }
}
