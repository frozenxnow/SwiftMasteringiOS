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

class SectionHeaderAndFooterViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = Region.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      header, 재사용식별자 등록
//      UITableViewHeader, Footer class를 사용하기 때문에 interface를 만들지 않아도 됨
//        listTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        
        // 인터페이스 파일을 헤더로 등록
        let headerNib = UINib(nibName: "CustomHeader", bundle: nil)
        listTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
        
    }
}



extension SectionHeaderAndFooterViewController: UITableViewDataSource {
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
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return list[section].title
//    }
    
}




extension SectionHeaderAndFooterViewController: UITableViewDelegate {
    // custom header를 리턴하는 메소드는 delegate protocol에 정의되어 있습니다
    
    // 기존의 클래스를 이용하는 방법
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        // 이 함수는 재사용 큐 리턴 Or 새로운 큐 만들어서 리턴
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
//
//        headerView?.textLabel?.text = list[section].title
//        headerView?.detailTextLabel?.text = "lorem ipsum"
//
//        return headerView
//    }
    
    // subclassing하고 ui를 직접 구성하는 방법
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 이 함수는 재사용 큐 리턴 Or 새로운 큐 만들어서 리턴
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CustomHeaderView
        
        headerView.titleLabel.text = "\(list[section].title)"
        headerView.countLabel.text = "\(list[section].countries.count)"
        
        return headerView
    }
    
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
//            headerView.textLabel?.textColor = .systemBlue
//            headerView.textLabel?.textAlignment = .center
//            if headerView.backgroundView == nil {
//                let v = UIView(frame: .zero)
//                v.backgroundColor = .secondarySystemFill
//                v.isUserInteractionEnabled = false
//                headerView.backgroundView = v
//            }
//        }
//        
////        headerView?.backgroundColor = .secondarySystemFill
//    }
//    
}














