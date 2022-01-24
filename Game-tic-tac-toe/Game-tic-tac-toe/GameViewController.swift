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
    private let gameBoard = Gameboard()
    private lazy var referee = Referee(gameboard: self.gameBoard)
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goToFirstState()
        
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            
    
            
            if self.currentState.isCompleted == true && gameModeSigleton.shared.isAI == true && gameModeSigleton.shared.isComputerStateActive == false {
                self.goToComputerState()

            } else if self.currentState.isCompleted == true && gameModeSigleton.shared.isAI == true && gameModeSigleton.shared.isComputerStateActive == true {
                self.goToNextState()

            } else if self.currentState.isCompleted == true && gameModeSigleton.shared.isAI == false && gameModeSigleton.shared.isComputerStateActive == false {
                self.goToNextState()

            }
            
        }

        
    }
    
    
    
    private func goToFirstState() {
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
            return
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
            return
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
        }
        
        
    }
                
    @IBAction func restartButtonTapped(_ sender: Any) {
        self.goToFirstState()
        self.gameBoard.clear()
        self.gameboardView.clear()
        Log(.restartGame)
    }
    
}



