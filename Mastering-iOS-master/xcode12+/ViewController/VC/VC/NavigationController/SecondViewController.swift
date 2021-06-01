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

class SecondViewController: UIViewController {
   
   @IBAction func pop(_ sender: Any) {
      // 이전화면이 돌아가는 버튼은 back button으로 충분ㅇ하지만 직접 구현한다면 이렇게
    navigationController?.popViewController(animated: true) // VC를 nav stack에서 제거하고 이전화면으로 이동
   }
   
   @IBAction func pushThird(_ sender: Any) {
    guard let thirdVC = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") else {
        return
    }
    
    navigationController?.pushViewController(thirdVC, animated: true)
    
   }
   
   @objc func addRightButtons() {
      let btn1 = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
      let btn2 = UIBarButtonItem(title: "Two", style: .plain, target: nil, action: nil)
      
    let sw = UISwitch()
    let switchItem = UIBarButtonItem(customView: sw) // switch는 임베드해서 추가해야한다
    
    navigationItem.setRightBarButtonItems([switchItem, btn1, btn2], animated: true)
      
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
    
    // code로 bar button item을 추가할때는 주로 viewDidLoad() 에서 구현
    
    // back button이 다른 버튼과 함께 보이도록 설정
    navigationItem.leftItemsSupplementBackButton = true
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRightButtons))
      
   }
}


























