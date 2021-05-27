//
//  ColorCollectionViewCell.swift
//  CollectionView
//
//  Created by 지원 on 2021/05/27.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 스토리보드에서 초기화하지 못한 값들은 주로 여기에서 오버라이딩해서 구현
        
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = colorView.bounds.width / 2
    }
    
}
