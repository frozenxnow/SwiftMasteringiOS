//
//  ComposeDelegate.swift
//  DelegatePattern
//
//  Created by 지원 on 2021/03/17.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

protocol ComposeDelegate {
    // Delegate로 입력된 값을 전달하는 함수
    func composer(_ vc: UIViewController, didInput value: String?)
    
    // 값을 입력하지 않고 캔슬 버튼을 눌렀을 때
    func composerDidCancel(_ vc: UIViewController)
}
