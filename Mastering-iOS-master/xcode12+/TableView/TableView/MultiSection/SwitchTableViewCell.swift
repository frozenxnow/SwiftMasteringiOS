//
//  SwitchTableViewCell.swift
//  TableView
//
//  Created by 지원 on 2021/05/17.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 주로 여기에서 셀 초기화 코드 작성
        let v = UISwitch(frame: .zero)
        accessoryView = v
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
