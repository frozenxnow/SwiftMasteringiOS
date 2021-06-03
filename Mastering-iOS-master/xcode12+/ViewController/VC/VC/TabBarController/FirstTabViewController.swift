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

class FirstTabViewController: UIViewController {
    
    @IBAction func selectSecondTab(_ sender: Any) {
        
    }
    
    
    @IBAction func selectThirdTab(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tab bar item 속성 변경
        tabBarItem.title = "First" // 스토리보드에서 System item으로 지정되어서 코드가 무시됨 (badge만 적용)
        tabBarItem.badgeValue = "HOT"
        
        // 스토리보드에서 정한것 무시하려면 새로운 인스턴스 생성해서 할당해야함
//        tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        // 이렇게 추가하면 탭바컨트롤러가 첫번째 VC를 선택한 후 탭바 아이템을 교체했기 때문에 탭바아이템 컬러가 회색(비활성상태)으로 보임
        // awakeFromNib() 추가하여 거기에서 실행
    }
}


