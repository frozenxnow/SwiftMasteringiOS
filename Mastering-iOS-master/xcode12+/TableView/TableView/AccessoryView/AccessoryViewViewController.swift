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

class AccessoryViewViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    @objc func toggleEditMode() {
        listTableView.setEditing(!listTableView.isEditing, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleEditMode))
    }
}



extension AccessoryViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 4 {
            return tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Disclosure indicator"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = "Detail button"
            cell.accessoryType = .detailButton
        case 2:
            cell.textLabel?.text = "Detail disclosure button"
            cell.accessoryType = .detailDisclosureButton
        case 3:
            cell.textLabel?.text = "Checkmark"
            cell.accessoryType = .checkmark
        default:
            cell.textLabel?.text = "None"
            cell.accessoryType = .none
            
        }
        
        return cell
    }
}


// 셀 터치 시 새로운 화면을 푸시 방식으로, 디테일 터치 시 모달 방식으로 처리 코드 구현

extension AccessoryViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀을 탭했을 때 호출
        
        // push 방식
        
        if indexPath.row == 0 || indexPath.row == 2 {
            performSegue(withIdentifier: "pushSegue", sender: nil)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "modalSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // 셀의 디테일 버튼을 터치했을 때 호출
        if indexPath.row == 2 {
            performSegue(withIdentifier: "modalSegue", sender: nil)
        }
    }
}
