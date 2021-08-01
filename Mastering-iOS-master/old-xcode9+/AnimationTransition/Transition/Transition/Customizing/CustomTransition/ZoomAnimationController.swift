//
//  ZoomAnimationController.swift
//  Transition
//
//  Created by 지원 on 2021/08/01.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit

class ZoomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 클래스에 필요한 속성 선언
    let duration = TimeInterval(1) // 트랜지션 걸리는 시간
    
    var targetIndexPath: IndexPath?
    var targetImage: UIImage?
    
    var presenting = true // transition 방향을 구분할 수 있는 속성
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // 트랜지션 시간 리턴
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 애니메이터에서 가장 중요. 실제 트랜지션을 구현한다. 트랜지션과 관련된 모든 속성은 transitionContext를 사용해 전달된다
        // 트랜지션은 특별한 뷰 내부에서 처리되는데 컨텍스트가 제공하는 컨테이너뷰 사용
        let containerView = transitionContext.containerView
        
        if presenting {
            guard let fromVC = transitionContext.viewController(forKey: .from)?.childViewControllers.last as? CustomTransitionViewController else { fatalError() }
            guard let toVC = transitionContext.viewController(forKey: .to) as? ImageViewController else { fatalError() }
            
            // 루트뷰에 접근
            guard let fromView = transitionContext.view(forKey: .from) else { fatalError() }
            guard let toView = transitionContext.view(forKey: .to) else { fatalError() }
            
            // toViewController를 Transition이 완료되기 전까지 감추어야한다
            toView.alpha = 0.0
            containerView.addSubview(toView) // 직접 추가해야한다(프롬뷰는 자동으로 추가됨)
            
            // 사용자가 선택한 셀에 접근하여 셀프레임을 얻어 루트뷰 좌표로 변환하고 상수에 저장
            let targetCell = fromVC.listCollectionView.cellForItem(at: targetIndexPath!)
            let startFrame = fromVC.listCollectionView.convert(targetCell!.frame, to: fromView)
            
            // 트랜지션에 사용할 이미지뷰 생성
            let imgView = UIImageView(frame: startFrame)
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.image = targetImage
            containerView.addSubview(imgView)
            
            // 최종프레임을 상수에 저장하고 이미지뷰 프레임속성에 애니메이션을 적용
            let finalFrame = containerView.bounds
            
            UIView.animate(withDuration: duration) {
                imgView.frame = finalFrame
            } completion: { finished in
                toView.alpha = 1.0
                imgView.alpha = 0.0
                imgView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

        } else {
            // dismissal transition
            
        }
    }
    
    
}

