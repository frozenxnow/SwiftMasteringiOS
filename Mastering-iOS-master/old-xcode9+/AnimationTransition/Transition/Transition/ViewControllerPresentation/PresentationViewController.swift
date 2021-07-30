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

class PresentationViewController: UIViewController {
   
   @IBAction func unwindToHere(_ sender: UIStoryboardSegue) {
    
   }
   
   @IBAction func present(_ sender: Any) {
      // storyboard ID를 사용해 modalVC를 생성한다
    guard let modalVC = storyboard?.instantiateViewController(withIdentifier: "ModalViewController") else { return }
    // 새로운 화면 표시할 때는 UIViewController가 제공하는 present method 사용(present method는 항상 modal방식으로 작동한다)
    present(modalVC, animated: true, completion: nil)
    
    // push,replace와 같은 segue를 구현하고싶다면 Present가 아닌 다른 method 사용해야 함 : show, showDegailViewController
    // presentedVC를 제거하는 방법도 달라진다
    // dismiss: present로 나타난 VC만 제거할 수 있다
    
   }
}















