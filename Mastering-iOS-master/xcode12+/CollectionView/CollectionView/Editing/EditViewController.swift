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

class EditViewController: UIViewController {
    
    var selectedList = [UIColor]()
    var colorList = MaterialColorDataSource.generateMultiSectionData()
    
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    func emptySelectedList() {
        selectedList.removeAll()
        // 하나하나 indexPath 생성하여 삭제하는 것보다 데이터를 새로 읽는것이(reload) 더 효율적이다
        let targetSection = IndexSet(integer: 0)
        listCollectionView.reloadSections(targetSection)
    }
    
    
    func insertSection() {
        // 새로운 더미데이터를 생성하여 colorList 앞부분에 추가
        let sectionData = MaterialColorDataSource.Section()
        colorList.insert(sectionData, at: 0)
        
        let targetSection = IndexSet(integer: 1)
        listCollectionView.insertSections(targetSection) // 두번째 섹션으로 추가된다
    }
    
    
    func deleteSecondSection() {
        // 두번째 섹션 삭제
        colorList.remove(at: 0)
        let targetSection = IndexSet(integer: 1)
        listCollectionView.deleteSections(targetSection)
    }
    
    
    func moveSecondSectionToThird() {
        // 두번째 데이터를 세번째 데이터로 이동시키는 메서드
        let target = colorList.remove(at: 0)
        colorList.insert(target, at: 1)
        
        listCollectionView.moveSection(1, toSection: 2)
    }
    
    
    func performBatchUpdates() {
        // 두번째 섹션에서 추가와 삭제를 동시에 하는 코드
        let deleteIndexPaths = (1..<3).compactMap { _ in
            Int(arc4random_uniform(UInt32(colorList[0].colors.count)))
        }.sorted(by: >).map { IndexPath(item: $0, section: 1)}
        
        let insertIndexPaths = (1..<4).compactMap { _ in
            Int(arc4random_uniform(UInt32(colorList[0].colors.count)))
        }.sorted(by: <).map { IndexPath(item: $0, section: 1)}
        
        // 동시에 실행할때는 삭제 후 추가! 순서가 중요하다
        // 삭제는 내림차순으로 , 추가는 오름차순으로 한다
        deleteIndexPaths.forEach { colorList[0].colors.remove(at: $0.item) }
        insertIndexPaths.forEach { colorList[0].colors.insert(UIColor.random, at: $0.item) }
        
        // 배치방식으로 실행할 코드 전달, completion에는 배치 완료 후 실행할 코드
        listCollectionView.performBatchUpdates ({
            listCollectionView.deleteItems(at: deleteIndexPaths)
            listCollectionView.insertItems(at: insertIndexPaths)
        }, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
    }
}



extension EditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedList.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
            // 실제 데이터 먼저 수정하고 셀을 수정한다. 반드시 이 순서로 해야함
        } else {
            let deleted = colorList[indexPath.section - 1].colors.remove(at: indexPath.item)
            
            // collectionView.deleteItems(at: [indexPath])
            let  targetIndexPath = IndexPath(item: selectedList.count, section: 0)
            selectedList.append(deleted)
            // collectionView.insertItems(at: [targetIndexPath])
            
            collectionView.moveItem(at: indexPath, to: targetIndexPath)
            // fade in 애니메이션이 아니라 직접 이동하는 애니메이션이 나타난다
            
        }
    }
}



extension EditViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return colorList.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return selectedList.count
        }
        
        return colorList[section - 1].colors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.contentView.backgroundColor = selectedList[indexPath.row]
        default:
            cell.contentView.backgroundColor = colorList[indexPath.section - 1].colors[indexPath.item]
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! EditingHeaderCollectionReusableView
        
        if indexPath.section == 0 {
            header.titleLabel.text = "Selected Color List"
        } else {
            header.titleLabel.text = colorList[indexPath.section - 1].title
        }
        
        return header
    }
}



extension EditViewController {
    @objc func showMenu() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let emptyListAction = UIAlertAction(title: "Empty Selected List", style: .default) { [weak self] (action) in
            self?.emptySelectedList()
        }
        actionSheet.addAction(emptyListAction)
        
        let insertSectionAction = UIAlertAction(title: "Insert Section", style: .default) { [weak self] (action) in
            self?.insertSection()
        }
        actionSheet.addAction(insertSectionAction)
        
        let delectSecondSectionAction = UIAlertAction(title: "Delete Second Section", style: .default) { [weak self] (action) in
            self?.deleteSecondSection()
        }
        actionSheet.addAction(delectSecondSectionAction)
        
        let moveSectionAction = UIAlertAction(title: "Move Second Section to Third", style: .default) { [weak self] (action) in
            self?.moveSecondSectionToThird()
        }
        actionSheet.addAction(moveSectionAction)
        
        let batchUpdatesAction = UIAlertAction(title: "Perform Batch Update", style: .default) { [weak self] (action) in
            self?.performBatchUpdates()
        }
        actionSheet.addAction(batchUpdatesAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        if let pc = actionSheet.popoverPresentationController {
            pc.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
}



extension UIColor {
    static var random: UIColor {
        let r = CGFloat.random(in: 1..<256) / 255
        let g = CGFloat.random(in: 1..<256) / 255
        let b = CGFloat.random(in: 1..<256) / 255
        
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
    }
}

