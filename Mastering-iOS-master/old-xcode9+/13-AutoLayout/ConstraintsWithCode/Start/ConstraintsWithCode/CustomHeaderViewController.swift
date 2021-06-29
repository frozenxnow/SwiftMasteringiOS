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

class CustomHeaderViewController: UIViewController {
   
   @IBOutlet weak var blueView: UIView!
    
    // 새로운 top 제약을 추가
    var topToSuperview: NSLayoutConstraint?
    var topToSafeArea: NSLayoutConstraint?
   
   
   @IBAction func updateTopConstraint(_ sender: UISwitch) {
      // superview : off일때, safearea: on일때
    topToSuperview?.isActive = !sender.isOn
    topToSafeArea?.isActive = sender.isOn
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      layoutWithInitializer()
      //layoutWithVisualFormatLanguage()
      //layoutWithAnchor()
   }
}









extension CustomHeaderViewController {
   func layoutWithInitializer() {
    blueView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = NSLayoutConstraint(item: blueView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: blueView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: blueView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        let height = NSLayoutConstraint(item: blueView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        
        NSLayoutConstraint.activate([leading, top, trailing, height])
        
        topToSuperview = top
            if #available(iOS 11.0, *) {
                topToSafeArea = NSLayoutConstraint(item: blueView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0)
            } else {
                topToSafeArea = NSLayoutConstraint(item: blueView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            }
        
    }
}

extension CustomHeaderViewController {
   func layoutWithVisualFormatLanguage() {

   }
}


extension CustomHeaderViewController {
   func layoutWithAnchor() {

   }
}


