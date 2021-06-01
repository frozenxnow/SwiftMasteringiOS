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

class BottomViewController: UIViewController {
   
   @IBAction func removeFromParent(_ sender: Any) {
      // root view를 view 계층에서 먼저 제거
    view.removeFromSuperview()
      // container에서 제거
    removeFromParentViewController()
   }
    
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        // container에 추가되거나 삭제되기 직전 호출
        // 추가되는 시점에는 파라미터로 container view controller 전달, 삭제 시점에는 nil 전달
        super.willMove(toParentViewController: parent)
        print(String(describing: type(of: self)), #function, parent?.description ?? "nil")
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        // container에 추가되거나 삭제된 후
        super.didMove(toParentViewController: parent)
        print(String(describing: type(of: self)), #function, parent?.description ?? "nil")

    }
}













