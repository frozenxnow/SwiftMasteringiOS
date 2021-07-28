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

class MotionEffectViewController: UIViewController {
   
   @IBOutlet weak var targetImageView: UIImageView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
    
    // image의 x축에 motion effect 추가(1: motion effect를 적용할 속성에 대한 keyPath, 2: motion effect 종류(적용할 축))
    let x = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
    // motion effect 크기
    x.minimumRelativeValue = -100 // offset이 -1일때 사용할 최소값
    x.maximumRelativeValue = 100 // offset이 1일때 사용할 최대값
    
//    targetImageView.addMotionEffect(x) 
    
    let y = UIInterpolatingMotionEffect(keyPath: "cencer.y", type: .tiltAlongVerticalAxis)
    y.minimumRelativeValue = -100
    y.maximumRelativeValue = 100
    // motion effect를 추가하기
    
    let group = UIMotionEffectGroup()
    group.motionEffects = [x, y]
    targetImageView.addMotionEffect(group)
    
   }
}















