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


class CustomCellViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    let list = WorldTime.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀셀을 다른 씬에서도 사용하고싶다면 SharedCustomCell.xib 파일을 만들어
        // 그 파일 내에 커스텀 셀을 구현한다. 그리고 그 셀을 사용하려면ㄴ 대부분 viewDidLoad()에서 호출
        let cellNib = UINib(nibName: "SharedCustomCell", bundle: nil)
        // nibName: 파일 이름 / bundel: 인터페이스가 저장되어 있는 번들, 동일한 번들이라면 nil 전달
        listTableView.register(cellNib, forCellReuseIdentifier: "SharedCustomCell")
        // 첫 파라미터 : nib, 두번째 파라미터 : 재사용을 위한 식별자
        
    }
}

extension CustomCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // outlet으로 사용하기 위해서는 새로운 클래스인 TimeTableViewCell로 다운캐스팅이 필요합니다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedCustomCell", for: indexPath) as! TimeTableViewCell
        
        
        let target = list[indexPath.row]
        
        // 뷰태깅을 할 경우 타입캐스팅이 필요합니다
//        if let dateLabel = cell.viewWithTag(100) as? UILabel {
//            dateLabel.text = "\(target.date), \(target.hoursFromGMT)"
//        }
//
//        if let locationLabel = cell.viewWithTag(200) as? UILabel {
//            locationLabel.text = target.location
//        }
//
//        if let ampmLabel = cell.viewWithTag(300) as? UILabel {
//            ampmLabel.text = target.ampm
//        }
//
//        if let timeLabel = cell.viewWithTag(400) as? UILabel {
//            timeLabel.text = target.time
//        }
        
        // outlet 사용하기
        cell.dateLabel.text = "\(target.date), \(target.hoursFromGMT)"
        cell.locationLabel.text = target.location
        cell.ampmLabel.text = target.ampm
        cell.timeLabel.text = target.time
        
        return cell
    }
}
