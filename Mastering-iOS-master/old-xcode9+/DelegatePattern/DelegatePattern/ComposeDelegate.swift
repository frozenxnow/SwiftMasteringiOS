//
//  ComposeDelegate.swift
//  DelegatePattern
//
//  Created by 지원 on 2021/03/17.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

protocol ComposeDelegate {
    func composer(_ vc: UIViewController, didInput value: String?)
    func composerDidCancel(_ vc: UIViewController)
}
