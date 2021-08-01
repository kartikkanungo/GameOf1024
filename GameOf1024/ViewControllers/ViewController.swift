//
//  ViewController.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 31/07/21.
//

import UIKit

final class ViewController: UIViewController {
    private let reuseIdentifier = "CellIdentifer"
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    lazy var viewModel: BoardViewModel = BoardViewModel(postMoveDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyTheme()
        self.setupCollectionView()
        self.addGestures()
        
    }
    
    
    private func applyTheme() {
        resetButton.layer.borderWidth = 1
        resetButton.layer.cornerRadius = 4
        resetButton.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupCollectionView() {
        self.boardCollectionView.dataSource = self
        self.boardCollectionView.delegate = self
    }

    private func addGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    @objc private func respondToSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            self.viewModel.playMove(direction: .right)
        case .down:
            self.viewModel.playMove(direction: .down)
        case .left:
            self.viewModel.playMove(direction: .left)
        case .up:
            self.viewModel.playMove(direction: .up)
        default:
            break
        }
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        self.viewModel.resetTheGame()
    }
}

extension ViewController: PostMoveDelegate{
    func updateBoard() {
        self.boardCollectionView.reloadData()
    }
    
    func updateScore(score: String) {
        self.scoreLabel.text = score
    }
    
    func gameOver(message: String, title: String, ctaString: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cool! Reset The Game", style: .default, handler: { [weak self] action in
            self?.viewModel.resetTheGame()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //UICollectionViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    //UICollectionViewDatasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as? TileCollectionViewCell
        
        let (positionX, positionY) = self.getRowAndColForMatrix(indexPath: indexPath)
        let value = viewModel.getTheCurrentBoardState()[positionX][positionY]
        cell?.configure(value: value)

        return cell ?? UICollectionViewCell()
    }
    
    func getRowAndColForMatrix(indexPath: IndexPath) -> (Int,Int) {
        let index = indexPath.row
        
        if index < 4 {
            return (0, index % 4)
        } else if index >= 4 && index < 8 {
            return (1, index % 4)
        } else if index >= 8 && index < 12 {
            return (2, index % 4)
        } else {
            return (3, index % 4)
        }
    }
}
