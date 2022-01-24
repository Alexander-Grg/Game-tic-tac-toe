//
//  MenuViewController.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 21.01.2022.
//

import UIKit


class MenuViewController: UIViewController {
    
    @IBOutlet var gameVSComputerButton: UIButton!
    @IBOutlet var gameWithPlayerButton: UIButton!
    
    @IBAction func gameWithAIMode(_ sender: Any) {
        gameModeSigleton.shared.gameMode = .versusComputer
        performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    @IBAction func gameWithPlayerMode(_ sender: Any) {
        gameModeSigleton.shared.gameMode = .versusHuman
        performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


