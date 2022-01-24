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
        gameModeSigleton.shared.isAI = true
        
    }
    
    @IBAction func gameWithPlayerMode(_ sender: Any) {
        gameModeSigleton.shared.isAI = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


