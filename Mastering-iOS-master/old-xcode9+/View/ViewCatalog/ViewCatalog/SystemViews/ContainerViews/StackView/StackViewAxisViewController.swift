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

class StackViewAxisViewController: UIViewController {
   
   @IBOutlet weak var stackView: UIStackView!
   
   
   @IBAction func toggleAxis(_ sender: Any) {
      // 버튼을 탭하면 배치 방향을 toggle하도록 구현
    // animation 지원하기 때문에 이렇게 추가하면 애니메이션 효과도 사용 가능 
    UIView.animate(withDuration: 0.3) {
        if self.stackView.axis == .horizontal {
            self.stackView.axis = .vertical
        } else {
            self.stackView.axis = .horizontal
        }
    }
    
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}
