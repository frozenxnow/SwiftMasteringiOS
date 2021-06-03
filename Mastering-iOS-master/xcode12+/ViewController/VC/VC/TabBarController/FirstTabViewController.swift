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
        // 선택할 VC 지정하는 방법
        // child에서 tab bar controller에 접근할때는 tab bar controller 속성 사용
        guard let secondChild = tabBarController?.viewControllers?[1] else { return }
        
        tabBarController?.selectedViewController = secondChild
    }
    
    
    @IBAction func selectThirdTab(_ sender: Any) {
        // 선택할 tab을 index로 지정하는 방법, 코드가 단순하다
        tabBarController?.selectedIndex = 2
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // size가 맞지 않는 이미지 조절해서 tab bar item image로 사용하기. image literal 사용
        let regularImage = UIImage(named: "calendar_regular")
        let compactImage = UIImage(named: "calendar_compact")
        
        let item = UITabBarItem(title: "Calendar", image: regularImage, selectedImage: compactImage)
        item.badgeColor = UIColor.darkGray
        item.badgeValue = "7"
        
        tabBarItem = item

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tab bar item 속성 변경
//        tabBarItem.title = "First" // 스토리보드에서 System item으로 지정되어서 코드가 무시됨 (badge만 적용)
//        tabBarItem.badgeValue = "HOT"
        
        // 스토리보드에서 정한것 무시하려면 새로운 인스턴스 생성해서 할당해야함
//        tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        // 이렇게 추가하면 탭바컨트롤러가 첫번째 VC를 선택한 후 탭바 아이템을 교체했기 때문에 탭바아이템 컬러가 회색(비활성상태)으로 보임
        // awakeFromNib() 추가하여 거기에서 실행
    }
}


