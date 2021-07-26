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

class NotificationCenterViewController: UIViewController {
   
   @IBOutlet weak var valueLabel: UILabel!
   
    // 옵저버의 셀렉터로 들어가는 메서드는 노티피케이션 형태의 파라미터를 받는다
    @objc func process(notification: Notification) {
        
        // thread를 확인하는 코드
        print(Thread.isMainThread ? "Main Thread" : "Background Thread")
        
        
        guard let value = notification.userInfo?["NewValue"] as? String else {
            return
        }
        
        DispatchQueue.main.async {
            self.valueLabel.text = value
        }
        
        print("#1", #function)
    }
   override func viewDidLoad() {
      super.viewDidLoad()
    
    // 옵저버 등록 방법 1
    // 1. 옵저버로 지정할 객체, 2. 실행할 메서드를 selector로, 3. observer가 처리할 noti 이름, 4. sender를 제한할 때 사용(동일한 noti더라도 sender에 따라 실행코드가 달라진다면 이 파라미터에 sender를 전달해야 한다
    NotificationCenter.default.addObserver(self, selector: #selector(process(notification:)), name: NSNotification.Name.NewValueDidInput, object: nil)

    // 옵저버 등록 방법 2
    NotificationCenter.default.addObserver(forName: NSNotification.Name.NewValueDidInput, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
        print(Thread.isMainThread ? "MainThread" : "BackgroundThread")
        
        guard let value = notification.userInfo?["NewValue"] as? String else {
            return
        }
        
        self?.valueLabel.text = value
        
        print("#2 handling \(notification.name)", #function)
    }

   }
   
    
    // 소멸자: iOS 9 이하 버전, 특정 시점에 더이상 noti를 전달하지 않는 경우 observer를 직접 해제하는 코드를 작성한다
   deinit {
    NotificationCenter.default.removeObserver(self) // 인스턴스와 관련된 모든 observer 해제 (9 이하에서 실행O)
      print(#function)
   }
}


