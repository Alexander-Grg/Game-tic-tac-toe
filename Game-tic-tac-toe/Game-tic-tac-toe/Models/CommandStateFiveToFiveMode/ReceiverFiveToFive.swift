//
//  ReceiverFiveToFive.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 25.01.2022.
//

import Foundation

class ReceiverFiveToFive {
    
    func sendMessageToServerLog(message: String) {
        print(message)
    }
}

public func Log(action: Action) {
    
    let command = Command(action: action)
    Invoker.shared.addLogCommand(command: command)
}
