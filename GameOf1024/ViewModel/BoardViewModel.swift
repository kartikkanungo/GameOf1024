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
    private var goal: Int
    private var currentScore: Int
    
    init(logicManager: LogicManager = LogicManager(), goal: Int = 1024, currentScore: Int = 0) {
        self.logicManager = logicManager
        self.board = self.logicManager.getAFreshBoard()
        self.goal = goal
        self.currentScore = currentScore
    }
    
    public func getTheCurrentBoardState() -> GameBoard {
        return board
    }
    
    public mutating func execute(move: Move) {
        self.board = self.logicManager.execute(move: move, currentBoard: self.board)
    }
}
