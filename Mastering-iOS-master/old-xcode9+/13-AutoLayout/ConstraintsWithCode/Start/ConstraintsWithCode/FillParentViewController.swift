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

class FillParentViewController: UIViewController {
   
   @IBOutlet weak var bottomContainer: UIView!
   
   @IBOutlet weak var blueView: UIView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
//      layoutWithInitializer()
      layoutWithVisualFormatLanguage()
      //layoutWithAnchor()
   }
}








// NSLayoutConstraint를 사용해 코드로 제약 추가
extension FillParentViewController {
   func layoutWithInitializer() {
    blueView.translatesAutoresizingMaskIntoConstraints = false
    let leading = NSLayoutConstraint(item: blueView, attribute: .leading, relatedBy: .equal, toItem: bottomContainer, attribute: .leading, multiplier: 1.0, constant: 0)
    let trailing = NSLayoutConstraint(item: blueView, attribute: .trailing, relatedBy: .equal, toItem: bottomContainer, attribute: .trailing, multiplier: 1.0, constant: 0)
    let top = NSLayoutConstraint(item: blueView, attribute: .top, relatedBy: .equal, toItem: bottomContainer, attribute: .top, multiplier: 1.0, constant: 0)
    let bottom = NSLayoutConstraint(item: blueView, attribute: .bottom, relatedBy: .equal, toItem: bottomContainer, attribute: .bottom, multiplier: 1.0, constant: 0)
    
    // 활성화할 제약을 배열로 받는다
    NSLayoutConstraint.activate([leading, trailing, top, bottom])
   }
}



// Visual Format Language를 사용해 코드로 제약 추가
extension FillParentViewController {
   func layoutWithVisualFormatLanguage() {
    blueView.translatesAutoresizingMaskIntoConstraints = false
    
    // 수평, 수직을 동시에 표현할 수 없어서 각각 해야함
    let horzFmt = "|[b]|" // H: 생략해도 됨
    let vertFmt = "V:|[b]|"
    
    let views: [String: Any] = ["b": blueView] // views dictionary
    
    // 수평 방향의 제약
    let horzConstraints = NSLayoutConstraint.constraints(withVisualFormat: horzFmt, options: [], metrics: nil, views: views)
    
    let vertConstraints = NSLayoutConstraint.constraints(withVisualFormat: vertFmt, options: [], metrics: nil, views: views)
    
    // NSLayoutConstraint.constraints 함수는 배열을 리턴한다
    // 이 배열을 받아서 활성화시키면 제약이 적용됨
    NSLayoutConstraint.activate(horzConstraints + vertConstraints)
   }
    
    // 더욱 직관적이고 코드가 짧아 가독성이 높다
    // 문자열에서 사용하는 view의 이름은 dictionary의 key로 존재해야한다는 점이 중요
}



































// NSLayoutAnchor를 사용해 코드로 제약 추가
extension FillParentViewController {
   func layoutWithAnchor() {
      
   }
}

















































