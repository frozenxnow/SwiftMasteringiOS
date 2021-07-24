//
//  HalfEmbedingSegue.swift
//  Segue
//
//  Created by 지원 on 2021/07/23.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class HalfEmbedingSegue: UIStoryboardSegue {
    // overriding point 1. init
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination) // 상위 구현 먼저
    }
    
    // overriding point 2. perform
    override func perform() {
        // 실제 transition code 구현: custom segue 구현하면 transition과 관련된 모든것을 직접 처리해야함
        // 이 메서드가 return되는 시점에는 destinationVC가 화면에 정상적으로 표시되어야 한다
        
        // 애니메이션 시작 프레임
        var frame = source.view.bounds
        frame.origin.y = frame.height
        frame.size.height = frame.height / 2
        
        // 새로운 화면을 기존 뷰 계층에 추가하고 알파 속성을 0.0으로
        source.view.addSubview(destination.view)
        destination.view.frame = frame
        destination.view.alpha = 0.0
        
        source.addChildViewController(destination)
        
        frame.origin.y = source.view.bounds.height / 2
        
        UIView.animate(withDuration: 0.3) {
            self.destination.view.frame = frame
            self.destination.view.alpha = 1.0
        }
    }
}
