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

class AlignEdgeViewController: UIViewController {
   
   @IBOutlet weak var topContainer: UIView!
   
   @IBOutlet weak var bottomContainer: UIView!
   
   @IBOutlet weak var nameTitleLabel: UILabel!
   
   @IBOutlet weak var nameInputField: UITextField!
   
   @IBOutlet weak var emailTitleLabel: UILabel!
   
   @IBOutlet weak var emailInputField: UITextField!
   
   @IBOutlet weak var confirmButton: UIButton!
   
   var anchorView: UIView {
    // 항상 앵커뷰로 지정된 nameTitleLabel << 이걸 사용해서 코드를 짠다
      return nameTitleLabel
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
    
    // topContainer margin 설정하는 코드: 하위 버전 호환에 주의해야한다.
    // * iOS 버전에 따라 다르다
    if #available(iOS 11.0, *) {
        // * iOS 11 이후
        var current = topContainer.directionalLayoutMargins
        current.leading = 30
        topContainer.directionalLayoutMargins = current
        bottomContainer.directionalLayoutMargins = current
    } else {
        // * iOS 11 이전: UIEdgeInset 사용
        var current = topContainer.layoutMargins
        current.left = 30
        topContainer.layoutMargins = current
        bottomContainer.layoutMargins = current
    }
    
      layoutWithInitializer()
      //layoutWithVisualFormatLanguage()
      //layoutWithAnchor()
   }
}

extension AlignEdgeViewController {
   func layoutWithInitializer() {
    nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    nameInputField.translatesAutoresizingMaskIntoConstraints = false
    emailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    emailInputField.translatesAutoresizingMaskIntoConstraints = false
    confirmButton.translatesAutoresizingMaskIntoConstraints = false
    
    var leading = NSLayoutConstraint(item: nameTitleLabel, attribute: .leading, relatedBy: .equal, toItem: bottomContainer, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
    var top = NSLayoutConstraint(item: nameTitleLabel, attribute: .top, relatedBy: .equal, toItem: bottomContainer, attribute: .topMargin, multiplier: 1.0, constant: 0.0)
    var trailing = NSLayoutConstraint(item: nameTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: bottomContainer, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0)
    
    NSLayoutConstraint.activate([leading, top, trailing])
    
    // 앞으로 AnchorView 기준으로
    top = NSLayoutConstraint(item: nameInputField, attribute: .top, relatedBy: .equal, toItem: nameTitleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
    leading = NSLayoutConstraint(item: nameInputField, attribute: .leading, relatedBy: .equal, toItem: anchorView, attribute: .leading, multiplier: 1.0, constant: 0.0)
    trailing = NSLayoutConstraint(item: nameInputField, attribute: .trailing, relatedBy: .equal, toItem: anchorView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
    
    NSLayoutConstraint.activate([top, leading, trailing])
    
    
    top = NSLayoutConstraint(item: emailTitleLabel, attribute: .top, relatedBy: .equal, toItem: nameTitleLabel, attribute: .bottom, multiplier: 1.0, constant: 20.0)
    leading = NSLayoutConstraint(item: emailTitleLabel, attribute: .leading, relatedBy: .equal, toItem: anchorView, attribute: .leading, multiplier: 1.0, constant: 0.0)
    trailing = NSLayoutConstraint(item: emailTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: anchorView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
    
    NSLayoutConstraint.activate([top, leading, trailing])
    
    top = NSLayoutConstraint(item: emailInputField, attribute: .top, relatedBy: .equal, toItem: nameTitleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
    leading = NSLayoutConstraint(item: emailInputField, attribute: .leading, relatedBy: .equal, toItem: anchorView, attribute: .leading, multiplier: 1.0, constant: 0.0)
    trailing = NSLayoutConstraint(item: emailInputField, attribute: .trailing, relatedBy: .equal, toItem: anchorView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
    
    NSLayoutConstraint.activate([top, leading, trailing])
    
    
   }
}


































extension AlignEdgeViewController {
   func layoutWithVisualFormatLanguage() {
     
   }
}































extension AlignEdgeViewController {
   func layoutWithAnchor() {
      
   }
}




























