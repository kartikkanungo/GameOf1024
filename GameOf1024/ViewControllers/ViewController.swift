//
//  ViewController.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 31/07/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    lazy var viewModel: BoardViewModel = BoardViewModel(postMoveDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
        self.executeMoves()
    }
    
    func executeMoves() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewModel.playMove(direction: .up)
            self.viewModel.playMove(direction: .down)
            self.viewModel.playMove(direction: .left)
            self.viewModel.playMove(direction: .right)
            self.viewModel.playMove(direction: .left)
            self.viewModel.playMove(direction: .up)
        }
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        self.viewModel.resetTheGame()
    }
}

extension ViewController: PostMoveDelegate{
    func updateBoard() {
        
    }
    
    func updateScore(score: String) {
        self.scoreLabel.text = score
    }
    
    func gameOver(message: String) {
        let alert = UIAlertController(title: "Hi Player",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cool! Reset The Game", style: .default, handler: { [weak self] action in
            self?.viewModel.resetTheGame()
//            executeMoves()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
