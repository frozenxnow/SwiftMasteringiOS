//
//  SampleViewController.swift
//  SampleFramework
//
//  Created by 지원 on 2021/08/08.
//

import UIKit

class SampleViewController: UIViewController {
    
    public init() {
        super.init(nibName: "SampleViewController", bundle: Bundle(for: SampleViewController.self))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapButtonClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}














