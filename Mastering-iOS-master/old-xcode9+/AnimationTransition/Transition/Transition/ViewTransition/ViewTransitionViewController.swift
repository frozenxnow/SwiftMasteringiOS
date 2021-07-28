//
//  Copyright (c) 2018 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

class ViewTransitionViewController: UIViewController {
   
   @IBOutlet weak var containerView: UIView!
   @IBOutlet weak var redView: UIView!
   @IBOutlet weak var blueView: UIView!
   
   @IBAction func startTransition(_ sender: Any) {
    // blueView, redView 사이에 transition 추가하기
//    UIView.transition(with: containerView, duration: 1, options: [.transitionCurlUp], animations: {
//        // 실제 transition 구현
//        // transition 추가되는 실제 view는 첫번째 파라미터인 containerView에 속해야 한다.
//        // 1. 사라지는 view를 view계층에서 제거하고 새롭게 추가되는 view를 추가
//        // 2. isHidden속성 추가: view계층에 영향을 주지 않고 transition 구현
//        // 2번 사용하여 구현 - isHidden toggle한다
//        self.redView.isHidden = !self.redView.isHidden
//        self.blueView.isHidden = !self.blueView.isHidden
//    }, completion: nil)
    
    UIView.transition(from: redView, to: blueView, duration: 1, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: { finished in
        UIView.transition(from: self.blueView, to: self.redView, duration: 1, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
    })
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
    blueView.isHidden = false
   }
}
