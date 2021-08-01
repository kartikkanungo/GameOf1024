//
//  TileCollectionViewCell.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 02/08/21.
//

import UIKit

final class TileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tileValueLabel: UILabel!
    
    func applyTheme(value: Int) {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 2
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.backgroundColor = ThemeManager.tileColor(value)
    }
    
    func configure(value: Int) {
        applyTheme(value: value)
        self.tileValueLabel.text = String(value)
    }
}
