//
//  ViewController.swift
//  ImagePickerModalView
//
//  Created by 지원 on 2021/03/19.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func clickBtn(_ sender: Any) {
        
        self.present(UIImagePickerController(), animated: false)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


