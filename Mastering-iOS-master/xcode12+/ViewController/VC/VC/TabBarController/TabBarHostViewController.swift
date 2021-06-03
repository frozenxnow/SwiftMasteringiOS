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

class TabBarHostViewController: UIViewController {
    
    @IBAction func presentTabBarController(_ sender: Any) {
        // 코드로 연결할 때 적어도 한개 이상의 child가 필요하다
        // storyboard에서 identifier를 통해 child를 가져오는 방법: 이전에 구현해둔 그대로 가져오게 됨
        let firstVC = storyboard!.instantiateViewController(withIdentifier: "FirstTabViewController")
        // 만약 코드로 변경하고 싶다면 아래와 같은 방법으로 변경할 수 있다
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "SecondTabViewController")
        let thirdVC = storyboard!.instantiateViewController(withIdentifier: "ThirdTabViewController")
        
        // tab bar controller 인스턴스 생성
        let tbc = UITabBarController()
        tbc.viewControllers = [firstVC, secondVC, thirdVC] // 배열로 child를 가지는 viewControllers 속성
        present(tbc, animated: true, completion: nil) // tab bar controller를 모달 방식으로 추가
        
//        tbc.setViewControllers([firstVC, secondVC, thirdVC], animated: true)
//        애니메이션을 통해 child를 동적으로 추가할 수 있따
//        present(tbc, animated: true, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
