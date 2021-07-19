//
//  ViewController.swift
//  FirstStoryboard
//
//  Created by 지원 on 2021/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func viewModalVC(_ sender: UIButton) {
        
        let subStoryboard = UIStoryboard(name: "Sub", bundle: nil)
        // 확장자 제외한 서브스토리보드 이름, 동일한 bundle에 있으므로 nil 전달
        let modalVC = subStoryboard.instantiateViewController(withIdentifier: "modalVC")
        // guard let modalVC = storyboard?.instantiateViewController(withIdentifier: "modalVC") else { return }
        // 여기의 storyboard는 Main storyboard의 객체이기 때문에 storyboard reference를 했을 경우 storyboard == nil 이다
        present(modalVC, animated: true, completion: nil)
        
    }
    
    @IBAction func viewModalBackgroundVC(_ sender: UIButton) {
        let thirdStoryboard = UIStoryboard(name: "Third", bundle: nil)
        let modalVC = thirdStoryboard.instantiateViewController(identifier: "ThirdVC")
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

