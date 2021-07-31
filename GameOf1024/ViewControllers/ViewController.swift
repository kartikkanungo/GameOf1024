//
//  ViewController.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 31/07/21.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: BoardViewModel = BoardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.execute(move: .left)
        self.viewModel.execute(move: .up)
        self.viewModel.execute(move: .down)
        self.viewModel.execute(move: .right)
        self.viewModel.execute(move: .left)
        self.viewModel.execute(move: .up)
        self.viewModel.execute(move: .down)
        self.viewModel.execute(move: .right)
    }
}

