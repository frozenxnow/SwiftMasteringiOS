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

class ContainerViewController: UIViewController {
   
   
    @IBOutlet weak var bottomContainerView: UIView!
    
   @objc func removeChild() {
     // child 목록은 child View Controller속성에 배열로 저장되어있음
    for vc in childViewControllers {
        vc.willMove(toParentViewController: nil) // 직접 willMove 호출한다. 
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
    
        // child 추가하는 코드는 주로 viewDidLoad()에서 작성
        if let childVC = storyboard?.instantiateViewController(withIdentifier: "BottomViewController") {
            addChildViewController(childVC)
            childVC.didMove(toParentViewController: self) // 직접 didMove 호출해야한다. 호출이 안되더라고
            childVC.view.frame = bottomContainerView.bounds
            bottomContainerView.addSubview(childVC.view)
        }
          
          
        // navigation bar 옆에 버튼을 추가, removeChild() 와 연결
          navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeChild))
   }
}


extension ContainerViewController {
   override var description: String {
      return String(describing: type(of: self))
   }
}




















