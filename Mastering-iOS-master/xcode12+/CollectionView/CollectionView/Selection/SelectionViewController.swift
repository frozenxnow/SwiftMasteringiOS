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
        
    }
    
    
    func reset() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
                
        listCollectionView.allowsSelection = true
        listCollectionView.allowsMultipleSelection = true
        
    }
}


extension SelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = list[indexPath.item].color
        view.backgroundColor = color
        print("#1", indexPath, #function)
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










