//
//  BoardViewModel.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 01/08/21.
//

import Foundation

struct BoardViewModel {
    private var logicManager: LogicManager
    private var board: GameBoard
    
    init(logicManager: LogicManager = LogicManager()) {
        self.logicManager = logicManager
        self.board = self.logicManager.getAFreshBoard()
    }
    
    public func getTheCurrentBoardState() -> GameBoard {
        return board
    }
    
    public mutating func execute(move: Move) {
        self.board = self.logicManager.execute(move: move, currentBoard: self.board)
    }
}
