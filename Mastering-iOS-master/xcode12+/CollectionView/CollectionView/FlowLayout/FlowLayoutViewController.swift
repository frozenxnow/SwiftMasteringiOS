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

class FlowLayoutViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    let list = MaterialColorDataSource.generateMultiSectionData()
    
    
    @objc func toggleScrollDirection() {
        // 스크롤 방향을 토글하는 메서드
        guard let layout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        // performBatchUpdates의 첫 파라미터 : 실행될 블록,
        // 두번째 파라미터 : 실행 후 이루어질 동작
        listCollectionView.performBatchUpdates({
            layout.scrollDirection = layout.scrollDirection == .vertical ? .horizontal : .vertical
        }, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleScrollDirection))
        
        if let layout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
            
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
        
    }
}


extension FlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print(indexPath.section, "#1", #function)
        
        // collection view가 cell 배치 전 크기를 설정하기 위해 호출하는 메서드
        // indexPath로 cell 위치 확인
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        var bounds = collectionView.bounds
        bounds.size.height += bounds.origin.y
        
        var width = bounds.width - (layout.sectionInset.left + layout.sectionInset.right)
        var height = bounds.height - (layout.sectionInset.top + layout.sectionInset.bottom)
        
        switch layout.scrollDirection {
        case .vertical:
            height = (height-(layout.minimumLineSpacing * 4)) / 5
            if indexPath.item > 0 {
                width = (width - (layout.minimumInteritemSpacing * 2)) / 3
            }
        case .horizontal:
            width = (width - (layout.minimumLineSpacing * 2)) / 3
            if indexPath.item > 0 {
                height = (height - (layout.minimumInteritemSpacing * 4)) / 5
            }
        }
        
        return CGSize(width: width.rounded(.down), height: height.rounded(.down))
            // .rounded(.down)으로 소숫점을 없애 오차를 줄인다 
    }
    
    
    // viewDidLoad() 에서 직접 설정해줌
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        print(section, "#2", #function)
//        // 여백이 필요할 때마다 호출
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        print(section, "#3", #function)
//        // 여백이 필요할 때마다 호출
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        print(section, "#4", #function)
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
}

extension FlowLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].colors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = list[indexPath.section].colors[indexPath.row]
        
        return cell
    }
}




