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

extension NSNotification.Name {
    static let NewValueDidInput = NSNotification.Name("NewValueDidInputNotification")
}

class ComposeViewController: UIViewController {
   
   @IBOutlet weak var inputField: UITextField!
   
   @IBAction func close(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
    // textField에 입력된 값을 가져온다
   @IBAction func postValue(_ sender: Any) {
    guard let text = inputField.text else {
        return
    }
    
    // background thread에서 noti를 전달하도록 DispatchQueue.global().async 안에 메서드 추가 
    DispatchQueue.global().async {
        // 파라미터1: 노티피케이션 이름 (위에서 extension으로 추가했음)
        // 파라미터2: 노티피케이션을 전달하는 객체의 이름
        // 파라미터3: 노티피케이션과 연관된 데이터 값을 dictionary 형태로 전달 (번거롭지만 무조건 딕셔너리)
        NotificationCenter.default.post(name: NSNotification.Name.NewValueDidInput, object: nil, userInfo: ["NewValue": text])
    }
    
      dismiss(animated: true, completion: nil)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      inputField.becomeFirstResponder()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      inputField.resignFirstResponder()
   }
}

