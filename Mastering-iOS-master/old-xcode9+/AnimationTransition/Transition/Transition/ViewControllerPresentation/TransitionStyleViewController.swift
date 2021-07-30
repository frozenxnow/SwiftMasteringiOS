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

class TransitionStyleViewController: UIViewController {
   
   var selectedTransitionStyle = UIModalTransitionStyle.coverVertical // 선택하는 표시방법이 저장되는 변수
   
   @IBAction func styleChanged(_ sender: UISegmentedControl) {
      selectedTransitionStyle = UIModalTransitionStyle(rawValue: sender.selectedSegmentIndex) ?? .coverVertical
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // segue를 동적으로 설정하고싶다면 prepare단계(VC표시 이전)에서 세팅한다
    let presentedVC = segue.destination
    
    presentedVC.modalTransitionStyle = selectedTransitionStyle
   }
   
   
   @IBAction func present(_ sender: Any) {
      let sb = UIStoryboard(name: "Presentation", bundle: nil)
      let modalVC = sb.instantiateViewController(withIdentifier: "ModalViewController")
      
    modalVC.modalTransitionStyle = selectedTransitionStyle
      
      present(modalVC, animated: true, completion: nil)
   }
}

















