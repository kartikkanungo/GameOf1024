//
//  LogicManager.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 31/07/21.
//

import Foundation

/*
 DRAFT(In Progress)
 
 Init: Provide a 4 X 4 matrix at any state of the game
 
 Input: Direction and the matrix with the current state of the game
 OutPut: Matrix after executing the direction move or
         Generate a fresh Game
 
 Responsibilites of logic manager
 1. On getting direction as an input
    1. remove spaces (spaces means matrix value = 0)
    2. Check the neighbours value
        1. if same merge and add
            1. while merging source to destination:
                Destination = source + destination
                source = 0
        2. else do not do anything
    3. Remove spaces and Continue till the time when merge is not needed
 2. Generate number at a random position(where postion[i][j] = 0)
 
 */

typealias GameBoard = [[Int]]
typealias PositionIndex = [Int]
// MARK:- Move Direction
enum Move {
    case up
    case down
    case right
    case left
}

// MARK:- Logic Manager
struct LogicManager {
    // Input: Direction and the matrix with the current state of the game
    // OutPut: Matrix after executing the direction move
    
    private var index: [[Int]]
    
    init() {
        self.index = []
        setupIndex()
    }
    
    private mutating func setupIndex() {
        for x in 0..<4 {
            for y in 0..<4 {
                self.index.append([x,y])
            }
        }
    }
}

// MARK:- Execute move Methods
extension LogicManager {
    public func execute(move: Move, currentBoard: GameBoard) -> GameBoard {
        return self.makeAMove(direction: move, currentBoard: currentBoard)
    }
    
    private func makeAMove(direction: Move, currentBoard: GameBoard) -> GameBoard {
        
        return currentBoard
    }
}


// MARK:- Random values generator
extension LogicManager {
    private func generateNumberAtRandomPlace(board: GameBoard) -> GameBoard {
        var gameBoard = board
        let availablepositions = self.getAvailablePositions(board: board)
        let index = self.getRandomPosition(from: availablepositions)
        gameBoard[index.first!][index.last!] = self.getRandomTwoOrFour()
        return gameBoard
    }
    
    private func getAvailablePositions(board: GameBoard) -> [PositionIndex] {
        var availablepositions: [PositionIndex] = []
        for i in 0...board.count {
            for j in 0..<board.first!.count {
                if board[i][j] == 0 {
                    availablepositions.append([i,j])
                }
            }
        }
        return availablepositions
    }
    
    private func getRandomPosition(from array: [[Int]]) ->  [Int] {
        return array.randomElement()!
    }
    
    private func getRandomTwoOrFour() -> Int {
        return [2,4].randomElement()!
    }
}
