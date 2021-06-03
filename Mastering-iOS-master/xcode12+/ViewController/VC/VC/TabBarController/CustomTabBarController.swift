//
//  CustomTabBarController.swift
//  VC
//
//  Created by 지원 on 2021/06/03.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 순서 변경이 가능한 탭바아이템 배열로 저장하고 있는데, 여기에서 처음 두개를 제외시키면 첫 두 아이템은 순서 변경이 불가능해진다 
        customizableViewControllers = Array(customizableViewControllers!.dropFirst(2))
        
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
