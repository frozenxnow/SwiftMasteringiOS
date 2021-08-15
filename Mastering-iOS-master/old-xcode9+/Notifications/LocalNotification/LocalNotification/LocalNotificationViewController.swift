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
import  UserNotifications

// 메시지를 입력하고 시간을 선택한 다음 버튼을 탭하면 로컬노티피케이션 예약
class LocalNotificationViewController: UIViewController {
   var interval: TimeInterval = 1
   
   @IBOutlet weak var inputField: UITextField!
   
   @IBAction func schedule(_ sender: Any) {
      // local noti 예약
    let content = UNMutableNotificationContent() // 인스턴스 생성(속성을 사용해 noti생성)
    content.title = "Hello"
    content.body = inputField.text ?? "Empty body"
    content.badge = 123
    content.sound = UNNotificationSound.default()
    // 위 모든것은 권한 허가가 필요함
    
    // 트리거를 통해 로컬노티가 전달되는 조건을 지정
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
    
    // UNNotificationRequest 인스턴스 생성
    let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)

    // 실제 예약 요청
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print(error)
        } else {
            print("Done")
        }
    }
    
    inputField.text = nil
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}


extension LocalNotificationViewController: UIPickerViewDataSource {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return 60
   }
}

extension LocalNotificationViewController: UIPickerViewDelegate {
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return "\(row + 1)"
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      interval = TimeInterval(row + 1)
   }
}




















