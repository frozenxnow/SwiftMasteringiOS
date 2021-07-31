//
//  SimplePresentationController.swift
//  Transition
//
//  Created by 지원 on 2021/07/31.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import UIKit


// 프리젠테이션 컨트롤러에 필요한 기본 구성

class SimplePresentationController: UIPresentationController {
    let dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // 닫기버튼을 속성으로 저장하고 닫기 버튼 Top 제약 추가
    let closeButton = UIButton(type: .custom)
    var closeButtonTopConstraint: NSLayoutConstraint?
    
    // 지정생성자 오버라이딩
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        // 반드시 상위 구현을 호출해야함
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        closeButton.setImage(UIImage(named: "cloase"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    
    @objc func dismiss() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    // 오버라이딩
    override var frameOfPresentedViewInContainerView: CGRect {
        // presention은 containerView에서 실행된다
        // presentedViewController는 containerViewFrame 전체를 채우지만 이 메서드를 오버라이딩하면 원하는 프레임을 설정할 수 있다
        print(String(describing: type(of: self)), #function)
        
        guard var frame = containerView?.frame else { return .zero }
        frame.origin.y = frame.size.height / 2
        frame.size.height = frame.size.height / 2
        
        return frame
    }
    
    // 오버라이딩
    override func presentationTransitionWillBegin() {
        // animation에 관련된 설정 구현 , 가장 중요한 오버라이딩 포인트
        print("\n\n")
        print(String(describing: type(of: self)), #function)

        guard let containerView = containerView else { fatalError() }
        // transition에 사용되는 모든 커스텀뷰는 반드시 컨테이너 속성이 리턴하는 뷰에 추가해야 한다
        
        dimmingView.alpha = 0.0
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)
        
        containerView.addSubview(closeButton)
        closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        // top 제약을 생성하고 Constant 값을 -80으로 설정하고
        closeButtonTopConstraint = closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -80)
        closeButtonTopConstraint?.isActive = true
        
        // 제약 적용
        containerView.layoutIfNeeded()
        
        // 60으로 바꾸고 애니메이션 실행: 트랜지션 코디네이터 활용
        closeButtonTopConstraint?.constant = 60
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
            return
        }
        
        coordinator.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 1.0
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
        }, completion: nil)

        
    }
    override func presentationTransitionDidEnd(_ completed: Bool) {
        print("\n\n")
        print(String(describing: type(of: self)), #function)
    }
    
    override func dismissalTransitionWillBegin() {
        print("\n\n")
        print(String(describing: type(of: self)), #function)
        
        closeButtonTopConstraint?.constant =  -80
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            presentingViewController.view.transform = CGAffineTransform.identity
            containerView?.layoutIfNeeded()
            return
        }
        
        coordinator.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 1.0
            self.presentingViewController.view.transform = CGAffineTransform.identity
            self.containerView?.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print("\n\n")
        print(String(describing: type(of: self)), #function)
    }
    
    override func containerViewDidLayoutSubviews() {
        print(String(describing: type(of: self)), #function)
    }
}
