//
//  ViewController.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 31/07/21.
//

import UIKit

class ViewController: UIViewController {

    private var logicManager = LogicManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        var board = logicManager.getAFreshBoard()
        logicManager.printTheBoard(board: board)
        board = logicManager.execute(move: .right, currentBoard: board)
        logicManager.printTheBoard(board: board)
        board = logicManager.execute(move: .left, currentBoard: board)
        logicManager.printTheBoard(board: board)
        board = logicManager.execute(move: .down, currentBoard: board)
        logicManager.printTheBoard(board: board)
        board = logicManager.execute(move: .up, currentBoard: board)
        logicManager.printTheBoard(board: board)
        
    }


}

