//
//  ViewController.swift
//  SampleSource
//
//  Created by 지원 on 2021/08/07.
//

import UIKit
import SampleFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = SampleObj()
        obj.openFunc()
    }
    
    @IBAction func tapButtonTest(_ sender: UIButton) {
        self.present(SampleViewController(), animated: true, completion: nil)
    }
    

}

