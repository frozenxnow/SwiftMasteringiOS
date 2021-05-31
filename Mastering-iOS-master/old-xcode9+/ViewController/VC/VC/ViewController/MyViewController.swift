//
//  MyViewController.swift
//  VC
//
//  Created by 지원 on 2021/05/31.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBAction func fromCode(_ sender: Any) {
//        let vc = UIViewController() // 새로운 view controller 생성
        
        // nib file 사용한 vc 만들기
        let vc = CustomNibViewController(nibName: "CustomNibViewController", bundle: nil)
        vc.view.backgroundColor = UIColor.systemRed
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
