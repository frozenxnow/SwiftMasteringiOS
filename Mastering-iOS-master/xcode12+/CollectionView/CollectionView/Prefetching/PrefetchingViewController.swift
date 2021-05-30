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

class PrefetchingViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    lazy var refreshControl: UIRefreshControl = { [weak self] in
        let control = UIRefreshControl()
        control.tintColor = self?.view.tintColor
        return control
    }()
    
    
    @objc func refresh() {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.list = Landscape.generateData()
            strongSelf.downloadTasks.forEach { $0.cancel() }
            strongSelf.downloadTasks.removeAll()
            Thread.sleep(forTimeInterval: 2)
            // data 초기화, reload하고 있다
            DispatchQueue.main.async {
                strongSelf.listCollectionView.reloadData()
                
                // refresh 작업 완료 추가: CollectionView 업데이트 후 자동으로 사라진다 
                strongSelf.listCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    
    var list = Landscape.generateData()
    var downloadTasks = [URLSessionTask]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data Prefetching을 구현해 Cell Prefetching의 효율을 극대화
        // ViewController를 Prefetching DataSource로 지정
        listCollectionView.prefetchDataSource = self // storyboard에서도 연결 가능
        
        // refresh control 연결
        listCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
}

// Data Prefetching을 구현해 Cell Prefetching의 효율을 극대화
extension PrefetchingViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // data를 미리 다운로드, 파일을 미리 가져오면 지연을 최소화할 수 있다
        // cell prefetching만 사용할 때보다 더욱 더 많은 이미지를 준비해둔다
        for indexPath in indexPaths {
            downloadImage(at: indexPath.item)
        }
        print(#function, indexPaths)
        // 여러번 호출될수 있고, 같은 indexPath가 전달될 수 있기 때문에 동일한 작업을 여러번 실행하지 않도록 구현해야함
        // >> downloadImage(at:)에서 이미지가 있는지 검증하는 과정을 추가했다
        
    }
    
    // prefetching 취소하는 메서드
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        // 제외되는 indexPath가 있을 때 실행된다
        print(#function, indexPaths)
        for indexPath in indexPaths {
            cancelDownload(at: indexPath.item)
        }
    }
    
    
}

extension PrefetchingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let imageView = cell.viewWithTag(100) as? UIImageView {
            if let image = list[indexPath.row].image {
                imageView.image = image
            } else {
                imageView.image = nil
                downloadImage(at: indexPath.row)
            }
        }
        
        return cell
    }
}


extension PrefetchingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // cell이 화면에 표시되기 직전에 호출
        // 파라미터로 표시할 셀과 indexPath 전달
        if let imageView = cell.viewWithTag(100) as? UIImageView {
            if let image = list[indexPath.row].image {
                imageView.image = image
            } else {
                imageView.image = nil
            }
        }
        
    }
}


extension PrefetchingViewController {
    func downloadImage(at index: Int) {
        guard list[index].image == nil else {
            return
        }
        
        let targetUrl = list[index].url
        guard !downloadTasks.contains(where: { $0.originalRequest?.url == targetUrl }) else {
            return
        }
        
        print(#function, index)
        
        let task = URLSession.shared.dataTask(with: targetUrl) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data, let image = UIImage(data: data), let strongSelf = self {
                strongSelf.list[index].image = image
                let reloadTargetIndexPath = IndexPath(row: index, section: 0)
                DispatchQueue.main.async {
                    if strongSelf.listCollectionView.indexPathsForVisibleItems.contains(reloadTargetIndexPath) == .some(true) {
                        strongSelf.listCollectionView.reloadItems(at: [reloadTargetIndexPath])
                    }
                }
                
                strongSelf.completeTask()
            }
        }
        task.resume()
        downloadTasks.append(task)
    }
    
    
    func completeTask() {
        downloadTasks = downloadTasks.filter { $0.state != .completed }
    }
    
    
    func cancelDownload(at index: Int) {
        let targetUrl = list[index].url
        guard let taskIndex = downloadTasks.index(where: { $0.originalRequest?.url == targetUrl }) else {
            return
        }
        let task = downloadTasks[taskIndex]
        task.cancel()
        downloadTasks.remove(at: taskIndex)
    }
}




