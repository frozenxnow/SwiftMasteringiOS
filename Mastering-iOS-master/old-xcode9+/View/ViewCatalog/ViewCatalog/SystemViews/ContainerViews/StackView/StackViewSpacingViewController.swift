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

class StackViewSpacingViewController: UIViewController {
   
   @IBOutlet weak var redView: UIView!
   @IBOutlet weak var horizontalStackView: UIStackView!
   @IBOutlet weak var spacingLabel: UILabel!
   @IBOutlet weak var spacingSlider: UISlider!
   
    // 범위: -30 ~ +30
   @IBAction func spacingChanged(_ sender: UISlider) {
    UIView.animate(withDuration: 0.3) {
        self.horizontalStackView.spacing = CGFloat(sender.value)
    }
    updateLabel()
   }
   
   private func updateLabel() {
      spacingLabel.text = "\(Int(horizontalStackView.spacing))"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      updateLabel()
      spacingSlider.value = Float(horizontalStackView.spacing)
    
        // redView, blueView의 spacing을 60으로
        // 두번째 파라미터로는 왼쪽뷰를 전달
    horizontalStackView.setCustomSpacing(60, after: redView)
    // CustomSpacing의 우선순위가 slider로부터 전달받는 값보다 더 높기 때문에
    // slider가 업데이트 되어도 redView, blueView의 spacing은 60으로 고정된다 
   }
}
