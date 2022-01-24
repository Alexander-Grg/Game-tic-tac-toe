//
//  gameModeSingleTon.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 21.01.2022.
//

import Foundation

final class gameModeSigleton {
    
    static let shared = gameModeSigleton()
    
    var isAI: Bool = false
    
    var isComputerStateActive: Bool = false
    
    private init (){}
}
