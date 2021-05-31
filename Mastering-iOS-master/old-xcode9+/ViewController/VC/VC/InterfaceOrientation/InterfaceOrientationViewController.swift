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

class InterfaceOrientationViewController: UIViewController {
   
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // iPad에서 실행될 때에는 모든 오리엔테이션 리턴
        // 아이폰에서는 Portrait UpsideDown 제외한 모든 오리엔테이션 리턴
        
        // 직접 구현해서 지원 방식을 선택할 수 있다
        return [.landscapeRight, .landscapeLeft]
    }
    
    override var shouldAutorotate: Bool {
        // default true : 회전이 감지될 경우 자동으로 회전된다
        return true
    }
    
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}
