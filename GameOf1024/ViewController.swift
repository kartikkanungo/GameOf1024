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
        logicManager.printTheBoard(board: logicManager.getAFreshBoard())
    }


}

