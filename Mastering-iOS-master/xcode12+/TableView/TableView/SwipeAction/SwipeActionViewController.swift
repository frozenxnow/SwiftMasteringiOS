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

class SwipeActionViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var list = [("Always laugh when you can. It is cheap medicine.", "Lord Byron"), ("I probably hold the distinction of being one movie star who, by all laws of logic, should never have made it. At each stage of my career, I lacked the experience.", "Audrey Hepburn"), ("Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.", "Steve Jobs")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



extension SwipeActionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].0
        cell.detailTextLabel?.text = list[indexPath.row].1
        
        return cell
    }
}



@available(iOS 11.0, *)
extension SwipeActionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 리딩방향(오른쪽)으로 스와이프했을때 왼쪽에 나타나는 메뉴
        // 액션을 만들어 UISwipeActionConfiguration에 담아 리턴
        let unreadAction = UIContextualAction(style: .normal, title: "읽지않음") { (action, view, completion) in
            completion(true) // 정상적으로 실행되었을때 true 전달
        }
        
        unreadAction.backgroundColor = UIColor.systemBlue
        unreadAction.image = UIImage(systemName: "envelope")
        
        let configuration = UISwipeActionsConfiguration(actions: [unreadAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 반대로 우>좌로 스와이프, 오른쪽에 메뉴 생성
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completion) in
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        let flagAction = UIContextualAction(style: .normal, title: "깃발 표시") { (action, view, completion) in
            completion(true)
        }
        
        flagAction.image = UIImage(systemName: "flag")
        flagAction.backgroundColor = UIColor.systemOrange
        
        let menuAction = UIContextualAction(style: .normal, title: "기타") { (action, view, completion) in
            completion(true)
        }
        
        menuAction.image = UIImage(systemName: "ellipsis")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, flagAction, menuAction])
        configuration.performsFirstActionWithFullSwipe = true // 셀 전체 스와이프 했을때 첫번째 액션이 자동으로 실행됨
        
        return configuration
    }
    
}















