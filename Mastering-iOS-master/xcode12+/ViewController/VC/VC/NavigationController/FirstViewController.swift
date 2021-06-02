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

class FirstViewController: UIViewController {
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
            
            if var list = navigationItem.rightBarButtonItems {
                let btn = UIBarButtonItem(title: "Item", style: .plain, target: nil, action: nil)
                list.append(btn)
                navigationItem.rightBarButtonItems = list
            }
        
        case false:
            // 왼쪽 버튼 제거
            navigationItem.leftBarButtonItem = nil
            // 오른쪽 아이템 버튼 제거
            let list = navigationItem.rightBarButtonItems?.dropLast()
            // 제거 후 새로운 배열을 right item에 저장
            navigationItem.rightBarButtonItems = Array(list!)
        }
    }
    
    
    
    
    @IBAction func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {
        
    }
   
   @IBAction func pushSecond(_ sender: Any) {
    guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") else {
        return
    }
    
    // 새로운 child push할 때에는 nav controller에 접근해야함
    // 모든 view controller는 nav controller 가지고 있다
    // view controller가 nav controller에 임베드 되어있다면 navigation controller 리턴, 없으면 nil
    navigationController?.pushViewController(secondVC, animated: true) // 전달할 뷰 입력
    
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // back button (second view에서 보이는 back button item의 title은 first에서 지정한다
    navigationItem.backBarButtonItem?.title = "Go Back"
   }
}




