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

// MARK:- Execute a move
extension LogicManager {
    public func execute(move: Move, currentBoard: GameBoard) -> GameBoard {
        return self.makeAMove(direction: move, currentBoard: currentBoard)
    }
    
    private func makeAMove(direction: Move, currentBoard: GameBoard) -> GameBoard {
        /*
         Consists of:
         1. remove Spcaes()
         2. Merge (destination = source + destination)
         3. source = 0
         4. Generate New Number
         5. remove Spcaes()
         */
        
        var board = self.removeSpaces(board: currentBoard, direction: direction)
        board = self.mergeIfPossible(board: board, direction: direction)
        board = removeSpaces(board: board, direction: direction)
        board = self.generateNumberAtRandomPlace(board: board)
        self.printTheBoard(board: board)
        return board
    }
    
    private func removeSpaces(board: GameBoard, direction: Move) -> GameBoard {
        var board = board
        switch direction {
        case .up:
            for col in 0..<board.first!.count {
                for row in 1..<board.count {
                    if board[row][col] != 0  {
                        for i in (0..<row) {
                            if board[i][col] == 0 {
                                board[i][col] = board[row][col]
                                board[row][col] = 0
                                break
                            }
                        }
                    }
                }
            }
            
        case .down:
            for col in 0..<board.first!.count {
                for row in (0..<(board.count - 1)).reversed() {
                    if board[row][col] != 0  {
                        for i in (row..<board.count).reversed() {
                            if board[i][col] == 0 {
                                board[i][col] = board[row][col]
                                board[row][col] = 0
                                break
                            }
                        }
                    }
                }
            }

        case .right:
            for row in 0..<(board.count) {
                for col in (0..<(board.count - 1)).reversed() {
                    if board[row][col] != 0 {
                        for i in (col..<board.count).reversed() {
                            if board[row][i] == 0 {
                                board[row].swapAt(col, i)
                                break
                            }
                        }
                    }
                }
            }
                
        case .left:
            for row in 0..<(board.count) {
                for col in 1..<board.count {
                    if board[row][col] != 0 {
                        for i in 0..<col {
                            if board[row][i] == 0 {
                                board[row].swapAt(col, i)
                                break
                            }
                        }
                    }
                }
            }
        }
        
        return board
    }
    
    private func mergeIfPossible(board: GameBoard, direction: Move) -> GameBoard {
        var board = board
        switch direction {
        case .up:
            for col in 0..<board.first!.count {
                for row in 1..<board.count {
                    if board[row][col] == board[row - 1][col] {
                        board[row - 1][col] += board[row][col]
                        board[row][col] = 0
                    }
                }
            }
            
        case .down:
            for col in 0..<board.first!.count {
                for row in (0..<(board.count - 1)).reversed() {
                    if board[row][col] == board[row + 1][col] {
                        board[row + 1][col] += board[row][col]
                        board[row][col] = 0
                    }
                }
            }
            
        case .right:
            for row in 0..<(board.count) {
                for col in (0..<(board.count - 1)).reversed() {
                    if board[row][col] == board[row][col + 1] {
                        board[row][col + 1] += board[row][col]
                        board[row][col] = 0
                    }
                }
            }
            
        case .left:
            for row in 0..<(board.count) {
                for col in 1..<board.count {
                    if board[row][col] == board[row][col - 1] {
                        board[row][col - 1] += board[row][col]
                        board[row][col] = 0
                    }
                }
            }
        }
        return board
    }
}

// MARK:- Generate a fresh game
extension LogicManager {
    public mutating func getAFreshBoard() -> GameBoard {
        var board = self.getZerosBoard()
        board = self.generateNumberAtRandomPlace(board: board)
        board = self.generateNumberAtRandomPlace(board: board)
        return board
    }
    
    private func getZerosBoard() -> GameBoard {
        let board = [[0,0,0,0],
                     [0,0,0,0],
                     [0,0,0,0],
                     [0,0,0,0]]
        return board
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
        for i in 0..<board.count {
            for j in 0..<board.first!.count {
                if board[i][j] == 0 {
                    availablepositions.append([i,j])
                }
            }
        }
        return availablepositions
    }
    
    private func getRandomPosition(from array: GameBoard) ->  PositionIndex {
        return array.randomElement()!
    }
    
    private func getRandomTwoOrFour() -> Int {
        return [2,4].randomElement()!
    }
}

// MARK:- Print Board
extension LogicManager {
    public func printTheBoard(board: GameBoard) {
        for row in 0..<board.count {
            print(board[row])
        }
        
        print("---------------")
    }
}
