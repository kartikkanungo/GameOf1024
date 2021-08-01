//
//  BoardViewModel.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 01/08/21.
//

import Foundation
import UIKit

protocol PostMoveDelegate {
    func updateBoard()
    func updateScore(score: String)
    func gameOver(message: String)
}

struct BoardViewModel {
    private enum CurrentStatus {
        case freshGame
        case canPlay(move: Move)
        case won
        case lost
    }
    
    private var logicManager: LogicManager
    private var board: GameBoard
    private var goal: Int
    private var currentScore: Int
    private var postMoveDelegate: PostMoveDelegate
    
    private var currentStatus: CurrentStatus {
        didSet {
            switch currentStatus {
            case .freshGame:
                break
            case let .canPlay(move):
                self.execute(move: move)
            case .lost:
                self.postMoveDelegate.gameOver(message: "Sorry! You Lost!")
            case .won:
                self.postMoveDelegate.gameOver(message: "Congrats!")
            }
        }
    }
    
    init(logicManager: LogicManager = LogicManager(),
         goal: Int = 8,
         currentScore: Int = 0,
         postMoveDelegate: PostMoveDelegate) {
        self.logicManager = logicManager
        self.board = self.logicManager.getAFreshBoard()
        self.goal = goal
        self.currentScore = currentScore
        self.postMoveDelegate = postMoveDelegate
        self.currentStatus = .freshGame
    }
    
    public func getTheCurrentBoardState() -> GameBoard {
        return board
    }
    
    public func getTheCurrentScore() -> String {
        return String(self.currentScore)
    }
}

//MARK:- Execute Moves
extension BoardViewModel {
    public mutating func playMove(direction: Move) {
        switch currentStatus {
        case .freshGame:
            self.currentStatus = .canPlay(move: direction)
        case let .canPlay(direction):
            self.currentStatus = .canPlay(move: direction)
        case .won:
            break
        case .lost:
            break
        }
    }
    
    private mutating func execute(move: Move) {
        var scoreFortheMove = 0
        var numberGenerationSuccessful = false
        (self.board, scoreFortheMove, numberGenerationSuccessful) = self.logicManager.execute(move: move,
                                                                                              currentBoard: self.board)
        self.postMakingAMove(numberGenerationSuccessful: numberGenerationSuccessful,
                             scoreFortheMove: scoreFortheMove)
    }
    
    private mutating func postMakingAMove(numberGenerationSuccessful: Bool,
                                          scoreFortheMove: Int) {
        if !numberGenerationSuccessful &&
            !self.checkIfMergeIsPossible() {
            self.currentStatus = .lost
            return
        }
        self.currentScore += scoreFortheMove
        postMoveDelegate.updateBoard()
        postMoveDelegate.updateScore(score: String(self.currentScore))
        self.checkIfUserWon()
        print(self.currentScore)
    }
    
    private func checkIfMergeIsPossible() -> Bool {
        for row in 0..<board.count {
            for col in 0..<board.first!.count {
                if (col + 1) < board.first!.count  &&
                    (board[row][col] == board[row][col + 1])  {
                    return true
                }
                
                if (col - 1) >= 0  &&
                    (board[row][col] == board[row][col - 1]) {
                    return true
                }
                
                if (row + 1) < board.count &&
                    (board[row][col] == board[row + 1][col]) {
                    return true
                }
                
                if (row - 1) >= 0  &&
                    (board[row][col] == board[row - 1][col]) {
                    return true
                }
            }
            
        }
        return false
    }
    
    private mutating func checkIfUserWon() {
        var highestValue = 0
        for row in 0..<self.board.count {
            for col in 0..<self.board.count {
                highestValue = max(highestValue, board[row][col])
            }
        }
        if highestValue == self.goal {
            self.currentStatus = .won
        }
    }
    
    public mutating func resetTheGame() {
        self.board = self.logicManager.getAFreshBoard()
        self.currentScore = 0
        self.currentStatus = .freshGame
        self.postMoveDelegate.updateScore(score: "0")
    }
}
