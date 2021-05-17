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

class MultiSectionTableViewViewController: UIViewController {
    
    let list = PhotosSettingSection.generateData()
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    
    @objc func toggleHideAlbum(_ sender: UISwitch) {
        print(#function)
        list[1].items[0].on.toggle()
    }
    
    @objc func toggleAutoPlayVideos(_ sender: UISwitch) {
        print(#function)
        list[2].items[0].on.toggle()
    }
    
    @objc func toggleSummarizePhotos(_ sender: UISwitch) {
        print(#function)
        list[2].items[1].on.toggle()
    }
    
    @objc func toggleShowHolidayEvents(_ sender: UISwitch) {
        print(#function)
        list[3].items[1].on.toggle()
    }
    
    func showActionSheet() {
        let sheet = UIAlertController(title: nil, message: "Resetting will allow previously blocked people, places, dates, or holidays to once again be included in new Memories.", preferredStyle: .actionSheet)
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive, handler: nil)
        sheet.addAction(resetAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cancelAction)
        
        if let pc = sheet.popoverPresentationController {
            if let tbl = view.subviews.first(where: { $0 is UITableView }) as? UITableView {
                if let cell = tbl.cellForRow(at: IndexPath(row: 0, section: 3)) {
                    pc.sourceView = cell
                    pc.sourceRect = tbl.frame
                }
            }
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // scene이 표시되기 직전 호출
        super.viewWillAppear(animated)
        
        if let selected = listTableView.indexPathForSelectedRow {
            listTableView.deselectRow(at: selected, animated: true) // 선택된 회색 배경이 흰색으로 돌아온다
        }
    }
}





extension MultiSectionTableViewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
        // section의 개수 리턴하는 함수
        // 필수 함수는 아닙니다
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].items.count
        // section마다 리턴
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = list[indexPath.section].items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: target.type.rawValue, for: indexPath)
        
        cell.textLabel?.text = target.title

        switch target.type {
        case .disclosure:
            cell.imageView?.image = UIImage(systemName: target.imageName ?? "")
        case .switch:
            if let switchView = cell.accessoryView as? UISwitch {
                switchView.isOn = target.on
                
                if indexPath.section == 1 && indexPath.row == 0 {
                    switchView.removeTarget(nil, action: nil, for: .valueChanged)
                    switchView.addTarget(self, action: #selector(toggleHideAlbum(_:)), for: .valueChanged)
                }
                
                if indexPath.section == 2 && indexPath.row == 0 {
                    switchView.removeTarget(nil, action: nil, for: .valueChanged)
                    switchView.addTarget(self, action: #selector(toggleAutoPlayVideos(_:)), for: .valueChanged)
                }
                
                if indexPath.section == 2 && indexPath.row == 1 {
                    switchView.removeTarget(nil, action: nil, for: .valueChanged)
                    switchView.addTarget(self, action: #selector(toggleSummarizePhotos(_:)), for: .valueChanged)
                }
                
                if indexPath.section == 3 && indexPath.row == 1 {
                    switchView.removeTarget(nil, action: nil, for: .valueChanged)
                    switchView.addTarget(self, action: #selector(toggleShowHolidayEvents(_:)), for: .valueChanged)
                }
            }
        case .action:
                break
        case .checkmark:
            cell.accessoryType = target.on ? .checkmark : .none
        }
        
        return cell
        
    }
    
    // header ,footer
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].header
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return list[section].footer
    }
    
}

extension MultiSectionTableViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 탭하면 호출되는 메서드
        
        if indexPath.section == 3 && indexPath.row == 0 {
            showActionSheet()
            if let selected = listTableView.indexPathForSelectedRow {
                listTableView.deselectRow(at: selected, animated: true)
            }
        }
        
        if indexPath.section == 4 {
            if let cell = tableView.cellForRow(at: indexPath) {
                list[indexPath.section].items[indexPath.row].on.toggle()
                cell.accessoryType = list[indexPath.section].items[indexPath.row].on ? .checkmark : .none
                
            }
        }
        
    }
}
