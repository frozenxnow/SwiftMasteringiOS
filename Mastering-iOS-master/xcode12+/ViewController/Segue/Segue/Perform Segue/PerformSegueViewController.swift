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

class PerformSegueViewController: UIViewController {
    
    
    @IBOutlet weak var grantedSwitch: UISwitch!
    
    
    @IBAction func perform(_ sender: Any) {
        // sender에는 트리거를 전달하는 컨트롤 입력
        performSegue(withIdentifier: "manualSegue", sender: self)
        // segue를 찾으면 정상적으로 동작, 찾지 못하면 crash 발생
    }
    
    
    // segue 객체와 destinationVC가 생성되고 트랜지션이 실행되기 직전에 호출
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // type casting 필요
        if let vc = segue.destination as? MessageViewController {
            vc.segueName = segue.identifier
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // trigger가 segue 실행을 요청하고 실제 segue 객체가 생성되기 전 호출
        // true: segue 실행
        // false: 바로 종료
        // segue 객체와 DestinationVC 생성되기 전이기 때문에 prepare함수처럼 구현 불가능
        
        // switch On 상태일때 push 탭 가능(segue 실행), Off : return false(종료)
        if identifier == "conditionalSegue" {
            return grantedSwitch.isOn
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




















