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

class CustomizingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // navigation에 접근할 때에는 navigation controller를 통해 접근
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
        if #available(iOS 11.0, *) {
            // title 속성 설정하기
            // dict에 저장해야하고 key type은 NSAttributedStringKey, value type은 Any
            var attrs = [NSAttributedStringKey: Any]()
            attrs[.font] = UIFont.boldSystemFont(ofSize: 60) // font bold, size 60 pt
            attrs[.foregroundColor] = UIColor.black // text color 설정
            
            // shadow 속성 설정하기
            let shadow = NSShadow()
            shadow.shadowOffset = CGSize(width: 3, height: 3)
            shadow.shadowColor = UIColor.white
            
            // shadow key를 생성해 attrs dictionary에 저장
            attrs[.shadow] = shadow
            
            // navigation bar에 접근해 large title attribute에 저장
            navigationController?.navigationBar.largeTitleTextAttributes = attrs
        }
    }

}























