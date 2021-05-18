//
//  CustomAccessoryTableViewCell.swift
//  TableView
//
//  Created by 지원 on 2021/05/18.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class CustomAccessoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        // 초기화 코드는 주로 이곳에서 작성
        super.awakeFromNib()
        
        let v = UIImageView(image: UIImage(systemName: "star"))
        accessoryView = v // accessory type을 무시하게 됨
//        editingAccessoryView // 편집모드에서 보이는 악세서리뷰
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
