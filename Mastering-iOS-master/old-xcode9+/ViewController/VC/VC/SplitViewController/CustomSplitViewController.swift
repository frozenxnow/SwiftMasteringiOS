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

class CustomSplitViewController: UISplitViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      delegate = self
   }
   
   func setupDefaultValue() {
    // 마스터VC는 네비게이션C에 임베드 되어있다
        guard let nav = viewControllers.first as? UINavigationController, let masterVC = nav.viewControllers.first as? ColorListTableViewController else { return }
        guard let detailVC = viewControllers.last as? ColorDetailViewController else { return }
        
        // master VC -> List 속성에 저장
        // detail VC -> Color 속성에 저장
        detailVC.color = masterVC.list.first
    }

}

extension CustomSplitViewController: UISplitViewControllerDelegate {
    // horz size class가 compact로 바뀔 때마다 호출된다
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true // detailVC가 화면에서 사라지고 masterVC가 표시된다
    }
}
























