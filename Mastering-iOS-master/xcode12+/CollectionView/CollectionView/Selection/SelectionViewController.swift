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

class SelectionViewController: UIViewController {
    
    lazy var list: [MaterialColorDataSource.Color] = {
        (0...2).map { _ in
            MaterialColorDataSource.generateSingleSectionData()
        }.reduce([], +)
    }()
    
    
    lazy var checkImage: UIImage? = UIImage(systemName: "checkmark.circle")
    
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    func selectRandomItem() {
        let item = Int(arc4random_uniform(UInt32(list.count)))
        let targetIndexPath = IndexPath(item: item, section: 0)
        
        listCollectionView.selectItem(at: targetIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    func reset() {
        // 모든 선택을 해제한다
//        선택된 셀을 모두 해제하는 메서드, 효율적이지 않다
//        listCollectionView.deselectItem(at: <#T##IndexPath#>, animated: <#T##Bool#>)
        
        // 위에서 사용했던 메서드에 nil을 전달해서 해제하는 방법도 있다
        listCollectionView.selectItem(at: nil, animated: true, scrollPosition: .left)
        // 스크롤 포지션을 전달해도 스크롤되지 않는다, 스크롤 초기화가 필요하면 직접 스크롤해야한다.
        let firstIndexPath = IndexPath(item: 0, section: 0)
        listCollectionView.scrollToItem(at: firstIndexPath, at: .left, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
                
        listCollectionView.allowsSelection = true
        listCollectionView.allowsMultipleSelection = false
        
    }
}


extension SelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = list[indexPath.item].color
        view.backgroundColor = color
        print("#1", indexPath, #function)
        
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            // 태그를 사용해 이미지를 가져온다 태그값은 100으로 설정되어 있음
//            if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
//                imageView.image = checkImage
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // cell 선택 직전에 호출 true: 선택, false: 선택되지 않음
        // 조건에 따라 선택할지 안할지에 대한 검증
        print("#2", indexPath, #function)
        // 선택되어 있는 셀은 indexPathForSelectedItem으로 확인 : nil 이라면 true 리턴
        guard let list = collectionView.indexPathsForSelectedItems else {
            return true
        }
//        indexPath가 존재하지 않는 경우에만 true 리턴
        return !list.contains(indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        // 선택된 셀 선택해제 전 호출, ture 선택해제, false 선택해제되지 않음
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // 실제로 선택이 해제된 후 호출 : 선택해제 후 ui 업데이트에 활용
        
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            // 태그를 사용해 이미지를 가져온다 태그값은 100으로 설정되어 있음
//            if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
//                imageView.image = nil
//                // 선택이 해제되면 체크 이미지가 삭제된다
//            }
//        }
    }
    
    
    // highlight를 처리할수 있는 세가지 메서드가 있다
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        print("#3", indexPath, #function)
        return true // true 하이라이트 강조 false는 강조하지 않음, 셀 선택도 되지 않는다
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        // 하이라이트 강조 후 호출
        print("#4", indexPath, #function)
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 6
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        // 하이라이트 강조 해제시 호출
        print("#5", indexPath, #function)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 0
        }
    }
}



extension SelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = list[indexPath.row].color
        
        return cell
    }
}




extension SelectionViewController {
    @objc func showMenu() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let randomAction = UIAlertAction(title: "Select Random Item", style: .default) { [weak self] (action) in
            self?.selectRandomItem()
        }
        actionSheet.addAction(randomAction)
        
        let resetPositionAction = UIAlertAction(title: "Reset", style: .default) { [weak self] (action) in
            self?.reset()
        }
        actionSheet.addAction(resetPositionAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}










