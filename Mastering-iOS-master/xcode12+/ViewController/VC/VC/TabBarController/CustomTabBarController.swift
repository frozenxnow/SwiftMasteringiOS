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
        
        // delegate pattern 사용
        delegate = self
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

extension CustomTabBarController: UITabBarControllerDelegate {
    
    // tab 선택할 때마다 호출
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 두번째 VC는 선택할 수 없도록 구현
        if let secondVC = tabBarController.viewControllers?[1] {
            return viewController != secondVC
            // 그냥 false return할 경우 모든 tab bar item이 선택되지 않는다
        }

        return true // 실제로 선택된다. false 리턴시 선택되지 않음
    }
    
    
    // 코드로 구현한 버튼을 통한 이동도 금지해야할때는 새로운 메서드 추가
    // tab 선택 후 호출, 주로 선택 후 상태를 초기화할 때 사용한다
    // 두번째 파라미터를 통해 선택된 컨트롤러에 접근할 수 있다
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
}
