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
    
    let list = MaterialColorDataSource.generateSingleSectionData()
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 파라미터 1) viewController에 접근, 2) segue 실행시킨 객체 전달
        guard let cell = sender as? UICollectionViewCell else {
            return
        }
        
        guard let indexPath = listCollectionView.indexPath(for: cell) else {
            return
        }
        
        let target = list[indexPath.item]
        
        segue.destination.view.backgroundColor = target.color
        segue.destination.title = target.title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        listCollectionView.visibleCells
//        listCollectionView.cellForItem(at: <#T##IndexPath#>) index 위치의 셀 반환, 없다면 nil 반환
//        listCollectionView.indexPath(for: <#T##UICollectionViewCell#>)
    }
}




extension CustomCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorCollectionViewCell
        
        let target = list[indexPath.item]
        cell.colorView.backgroundColor = target.color
        cell.hexLabel.text = target.hex
        cell.nameLabel.text = target.title
        
        
        return cell
    }
}















