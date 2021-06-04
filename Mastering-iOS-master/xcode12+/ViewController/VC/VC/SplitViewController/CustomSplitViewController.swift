//
//  Mastering iOS
//  Copyright (c) KxCoding <help@kxcoding.com>
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
        // master view controller를 상수에 바인딩: view controller 배열의 첫번째 요소(navi controller에 임베드 되어있다
        guard let nav = viewControllers.first as? UINavigationController, let masterVC = nav.viewControllers.first as? ColorListTableViewController else { return }
        
        // detail view controller를 상수에 바인딩: view controller 배열 마지막에 저장되어 있다
        guard let detailVC = viewControllers.last as? ColorDetailViewController else {
            return
        }
        
        // detail view에 표시되는 데이터는 color 속성에 저장, master view에 표시되는 데이터는 list 속성에 저장
        detailVC.color = masterVC.list.first
    }
}



extension CustomSplitViewController: UISplitViewControllerDelegate {
    
}
























