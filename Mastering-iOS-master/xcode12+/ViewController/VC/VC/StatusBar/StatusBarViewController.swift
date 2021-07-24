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

class StatusBarViewController: UIViewController {
    
    // 임시 속성 추가
    var hidden = false
    
    override var prefersStatusBarHidden: Bool {
        return hidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide // slide animation 사용
    }
    
    
    @IBAction func toggleVisibility(_ sender: Any) {
//        prefersStatusBarHidden = !prefersStatusBarHidden // error , read-only
        hidden = !hidden // 여기까지 한다고 업데이트가 되는건 아니다
        
        UIView.animate(withDuration: 0.3) {
            // 업데이트 되었음을 시스템이 인지할 수 있도록 호출하는 특별한 메서드
            self.setNeedsStatusBarAppearanceUpdate() // VC에서 status bar와 연관된 것들 스캔하여 업데이트
        }
        
        
    }
    
    
    var style = UIStatusBarStyle.default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return style
    }
    
    @IBAction func toggleStyle(_ sender: Any) {
        style = style == .default ? .lightContent : .default
       
        
        let color = style == .default ? UIColor.white : UIColor.darkGray
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = color
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




extension StatusBarViewController {
    @IBAction func unwindToHere(_ sender: UIStoryboardSegue) {
        
    }
}













