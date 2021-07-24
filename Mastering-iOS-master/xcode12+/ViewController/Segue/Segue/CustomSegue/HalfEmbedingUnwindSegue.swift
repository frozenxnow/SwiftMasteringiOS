//
//  HalfEmbedingUnwindSegue.swift
//  Segue
//
//  Created by 지원 on 2021/07/23.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class HalfEmbedingUnwindSegue: UIStoryboardSegue {
    // Custom한 VC 내부에서 unwind로 연결되어있던 segue는 동작하지 않는다
    // 직접 unwind segue를 custom해주어야 한다
    
    override func perform() {
        // 최종 애니메이션 프레임 생성
        var frame = source.view.frame
        frame = frame.offsetBy(dx: 0, dy: frame.height)
        
        UIView.animate(withDuration: 0.3) {
            // frame, 알파 값 설정
            self.source.view.frame = frame
            self.source.view.alpha = 0.0
        } completion: { finished in
            self.source.view.removeFromSuperview()
            self.source.removeFromParentViewController()
        }

    }
}
