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

class ReorderingViewController: UIViewController {
    
    var list = MaterialColorDataSource.generateMultiSectionData()
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        // Collection View에서 제공하는 API 사용해서 제스처를 추적할 수 있도록 구현한다
        
        // 1. gesture 발생 위치 저장
        let location = sender.location(in: listCollectionView)
        
        // 2. switch문으로 발생 위치 분기
        
        switch sender.state {
        case .began:
            // gesture 시작시 호출, 대상 cell의 위치(indexPath)를 파라미터로 전달
            if let indexPath = listCollectionView.indexPathForItem(at: location) {
                listCollectionView.beginInteractiveMovementForItem(at: indexPath)
            }
        case .changed:
            // gesture 진행되는동안에는 터치 이벤트를 지속적으로 업데이트 해야함
            // 파라미터로 전달된 위치로 대상 cell을 이동시켜준다, cell 이동할 때마다 나머지 cell 위치도 자동으로 조절
            listCollectionView.updateInteractiveMovementTargetPosition(location)
        case .ended:
            // gesture 종료시 호출: cell이 gesture 종료된 위치로 이동하고 연관 delegate method 실행
            listCollectionView.endInteractiveMovement()
        default:
            // 작업 취소: cell이 원래 위치로 되돌아간다
            listCollectionView.cancelInteractiveMovement()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}



extension ReorderingViewController: UICollectionViewDataSource {
    
    // 실제 reordering 활성화하기 위해서는 몇가지 메서드를 구현해야한다
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // pan gesture 정상종료 후 호출: 삭제 후 추가!!
        let target = list[sourceIndexPath.section].colors.remove(at: sourceIndexPath.item)
        list[destinationIndexPath.section].colors.insert(target, at:destinationIndexPath.item)
    }
    
    // 별도의 제약이 없기 때문에 제약을 추가하고싶다면 또다른 메서드 추가
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        // 셀을 이동시키기 전에 호출된다. true: 이동 OK, false: 이동 금지된다
        return true
    }
    
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





