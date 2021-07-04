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

class GridViewController: UIViewController {
   
   @IBOutlet weak var redView: UIView!
   @IBOutlet weak var blueView: UIView!
   @IBOutlet weak var yellowView: UIView!
   @IBOutlet weak var blackView: UIView!
   
   @IBOutlet weak var bottomContainer: UIView!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
//      layoutWithInitializer()
      layoutWithVisualFormatLanguage()
//      layoutWithAnchor()
   }
}

extension GridViewController {
   func layoutWithInitializer() {
     // 생성자 방식으로 구현
    redView.translatesAutoresizingMaskIntoConstraints = false
    blueView.translatesAutoresizingMaskIntoConstraints = false
    yellowView.translatesAutoresizingMaskIntoConstraints = false
    blackView.translatesAutoresizingMaskIntoConstraints = false
    
    // 공통으로 사용하는 상수
    let margin: CGFloat = 10
    
    var leading = NSLayoutConstraint(item: redView, attribute: .leading, relatedBy: .equal, toItem: bottomContainer, attribute: .leading, multiplier: 1.0, constant: margin)
    var top = NSLayoutConstraint(item: redView, attribute: .top, relatedBy: .equal, toItem: bottomContainer, attribute: .top, multiplier: 1.0, constant: margin)
    
    var trailing = NSLayoutConstraint(item: redView, attribute: .trailing, relatedBy: .equal, toItem: blueView, attribute: .leading, multiplier: 1.0, constant: -margin)
    var bottom = NSLayoutConstraint(item: redView, attribute: .bottom, relatedBy: .equal, toItem: yellowView, attribute: .top, multiplier: 1.0, constant: -margin)
    
    NSLayoutConstraint.activate([leading, top, trailing, bottom])
    
    top = NSLayoutConstraint(item: blueView, attribute: .top, relatedBy: .equal, toItem: bottomContainer, attribute: .top, multiplier: 1.0, constant: margin)
    
    trailing = NSLayoutConstraint(item: blueView, attribute: .trailing, relatedBy: .equal, toItem: bottomContainer, attribute: .trailing, multiplier: 1.0, constant: -margin)
    
    bottom = NSLayoutConstraint(item: blueView, attribute: .bottom, relatedBy: .equal, toItem: blackView, attribute: .top, multiplier: 1.0, constant: -margin)
    
    NSLayoutConstraint.activate([top, trailing, bottom])
    
    leading = NSLayoutConstraint(item: yellowView, attribute: .leading, relatedBy: .equal, toItem: bottomContainer, attribute: .leading, multiplier: 1.0, constant: margin)
    
    bottom = NSLayoutConstraint(item: yellowView, attribute: .bottom, relatedBy: .equal, toItem: bottomContainer, attribute: .bottom, multiplier: 1.0, constant: -margin)
    
    trailing = NSLayoutConstraint(item: yellowView, attribute: .trailing, relatedBy: .equal, toItem: blackView, attribute: .leading, multiplier: 1.0, constant: -margin)
    
    NSLayoutConstraint.activate([leading, bottom, trailing])
    
    trailing = NSLayoutConstraint(item: blackView, attribute: .trailing, relatedBy: .equal, toItem: bottomContainer, attribute: .trailing, multiplier: 1.0, constant: -margin)
    
    bottom = NSLayoutConstraint(item: blackView, attribute: .bottom, relatedBy: .equal, toItem: bottomContainer, attribute: .bottom, multiplier: 1.0, constant: -margin)
    
    NSLayoutConstraint.activate([trailing, bottom])
    
    // 중복 코드를 줄이기 위해 UIView배열 생성
    let list: [UIView] = [blueView, yellowView, blackView]
    for v in list {
        let equalWidth = NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: redView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let equalHeight = NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: redView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([equalWidth, equalHeight])
    }
   }
    

}


extension GridViewController {
   func layoutWithVisualFormatLanguage() {
    
    redView.translatesAutoresizingMaskIntoConstraints = false
    blueView.translatesAutoresizingMaskIntoConstraints = false
    yellowView.translatesAutoresizingMaskIntoConstraints = false
    blackView.translatesAutoresizingMaskIntoConstraints = false
    
    // 공통으로 사용하는 상수
    let margin: CGFloat = 10
    
    // 수평, 수직 각 두개씩: 동일선상에 놓이는 뷰만 하나의 포맷문자열에서 표시할 수 있다 ex. 수평의 경우 : [red, blue] / [yellow, black]
    
    let horzFmt1 = "|-m-[red]-m-[blue(==red)]-m-|"
    let horzFmt2 = "|-m-[yellow]-m-[black(==yellow)]-m-|"
    
    let vertFmt1 = "V:|-m-[red]-m-[yellow(==red)]-m-|"
    let vertFmt2 = "V:|-m-[blue]-m-[black(==blue)]-m-|"
    
    // Views Dictionary
    let views: [String: Any] = ["red": redView, "blue": blueView, "yellow": yellowView, "black": blackView]
    // Metrics Dictionary (동일하게 쓰이는 margin 값)
    let metrics: [String: Any] = ["m": margin]
    
    var horzConstraints = NSLayoutConstraint.constraints(withVisualFormat: horzFmt1, options: [], metrics: metrics, views: views)
    
    NSLayoutConstraint.activate(horzConstraints)
    
    horzConstraints = NSLayoutConstraint.constraints(withVisualFormat: horzFmt2, options: [], metrics: metrics, views: views)
    
    NSLayoutConstraint.activate(horzConstraints)
    
    var vertConstraints = NSLayoutConstraint.constraints(withVisualFormat: vertFmt1, options: [], metrics: metrics, views: views)
    
    NSLayoutConstraint.activate(vertConstraints)
    
    vertConstraints = NSLayoutConstraint.constraints(withVisualFormat: vertFmt2, options: [], metrics: metrics, views: views)
    
    NSLayoutConstraint.activate(vertConstraints)
    
   }
}


extension GridViewController {
   func layoutWithAnchor() {
     
   }
}



























