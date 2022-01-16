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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.gameboardView.placeMarkView(Xview(), at: position)
        }
    }
    @IBAction func restartButtonTapped(_ sender: Any) {
    }
    
}
