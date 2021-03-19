//
//  ViewController.swift
//  DelegatePractice0
//
//  Created by 지원 on 2021/03/19.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btn: NSLayoutConstraint!
    @IBOutlet weak var printLabel: UILabel!
    @IBAction func clickBtn(_ sender: Any) {
        printLabel.text = textField.text
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        printLabel.text = textField.text
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
}

