//
//  gameModeSingleTon.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 21.01.2022.
//

import Foundation

final class gameModeSigleton {
    
    static let shared = gameModeSigleton()
    
    var gameMode: GameMode?
    var gameStatus: Bool = false
    var numberOfMovesPlayer1: [PlayerMove] = []
    var numberOfMovesPlayer2: [PlayerMove] = []
    
    private init (){}
}
