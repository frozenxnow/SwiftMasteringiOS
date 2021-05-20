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

class SingleSelectionViewController: UIViewController {
    
    let list = Region.generateData()
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    func selectRandomCell() {
        // 랜덤으로 셀을 선택하는 메소드 구현하기
        // 셀 선택시 index.row가 있어야 함. section과 indexPath를 랜덤으로 받아서 선택한다
        let section = Int.random(in: 0 ..< list.count)
        let row = Int.random(in: 0..<list[section].countries.count)
        let targetIndexPath = IndexPath(row: row, section: section)
        
        listTableView.selectRow(at: targetIndexPath, animated: true, scrollPosition: .top)
        // 세번째 파라미터 : 랜덤으로 선택한 후 셀로 스크롤을 하는지
    }
    
    
    func deselect() {
        // 선택을 제거하는 메서드
        if let selected = listTableView.indexPathForSelectedRow {
            listTableView.deselectRow(at: selected, animated: true)
            // 선택을 해제하는 메서드 deselectedRow(at:animated:)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                let first = IndexPath(row: 0, section: 0)
                self?.listTableView.scrollToRow(at: first, at: .top, animated: true)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu(_:)))
    }
    
    
    @objc func showMenu(_ sender: UIBarButtonItem) {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let selectRandomCellAction = UIAlertAction(title: "Select Random Cell", style: .default) { (action) in
            self.selectRandomCell()
        }
        menu.addAction(selectRandomCellAction)
        
        let deselectAction = UIAlertAction(title: "Deselect", style: .default) { (action) in
            self.deselect()
        }
        menu.addAction(deselectAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        menu.addAction(cancelAction)
        
        if let pc = menu.popoverPresentationController {
            pc.barButtonItem = sender
        }
        
        present(menu, animated: true, completion: nil)
    }
}




extension SingleSelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].countries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = list[indexPath.section].countries[indexPath.row]
        cell.textLabel?.text = target
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].title
    }
}




extension SingleSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // 선택되기 전 호출. nil을 리턴하면 셀이 선택되지 않는다. 특정 셀을 선택하지 못하도록 구현할 때 사용
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // 선택 직후 호출. indexPath : 선택된 셀의 위치 전달
//        let target = list[indexPath.section].countries[indexPath.row]
//        showAlert(with: target)
//        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
//    }
//
//    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
//        // 선택된 셀에서 선택이 해제되기 직전 호출. nil 리턴시 선택상태 유지
//        return indexPath
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        // 선택해제된 후 호출
//        print(#function, indexPath)
//        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .systemGray3
//
//    }
//
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        // 선택 시 강조되는 효과 false 리턴시 강조되지 않는다
//        return indexPath.row != 0
//    }
//
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        // 셀 강조 후 호출
//        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
//    }
//
//    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        // 강조효과 후 호출
//        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .systemGray3
//    }
    
}




extension UIViewController {
    func showAlert(with value: String) {
        let alert = UIAlertController(title: nil, message: value, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}



// cell의 custom class로 설정되어 있다
class SingleSelectionCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.textColor = .systemGray3
        textLabel?.highlightedTextColor = .black
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }
}






