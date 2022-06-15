//
//  GameStateCommandInvoker.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 25.01.2022.
//

import Foundation

class Invoker {
    
    public static let shared = Invoker()
    private let receiver = ReceiverFiveToFive()
    private let bufferSize = 5
    private var commands: [CommandFiveToFive] = []
    
    func addLogCommand(command: CommandFiveToFive) {
        commands.append(command)
        execute()
    }
    
    private func execute() {
        guard commands.count >= bufferSize else {
            return
        }
        
        commands.forEach { receiver.sendMessageToServerLog(message: $0.logMessage) }
        commands = []
    }
}
