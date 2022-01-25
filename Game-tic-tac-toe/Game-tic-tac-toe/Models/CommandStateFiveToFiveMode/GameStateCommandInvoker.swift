//
//  GameStateCommandInvoker.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 25.01.2022.
//

import Foundation

class Invoker {
    
    public static let shared = Invoker()
    
    private let receiver = Receiver()
    private let bufferSize = 5
    
    private var commands: [Command] = []
    
    func addLogCommand(command: Command) {
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
