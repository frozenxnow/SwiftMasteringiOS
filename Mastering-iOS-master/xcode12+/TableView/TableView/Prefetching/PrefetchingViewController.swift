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
    
    @IBOutlet weak var listTableView: UITableView!
    
    
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
            
            DispatchQueue.main.async {
                strongSelf.listTableView.reloadData()
                strongSelf.listTableView.refreshControl?.endRefreshing() // refreshing 작업 완료 메서드
                
            }
        }
    }
    
    
    var list = Landscape.generateData()
    var downloadTasks = [URLSessionTask]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prefetch 적용
        listTableView.prefetchDataSource = self
        
        // refresh 컨트롤 추가
        listTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
}


extension PrefetchingViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            downloadImage(at: indexPath.row)
        }
        print(#function, indexPaths)
    }
    
    // prefetching 대상에서 제외된 셀이 있을 때마다 호출, 두번째 파라미터로 인덱스패스 전달
    // 필수메서드는 아니지만 구현해주면 성능이 좋아집니다.
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        for indexPath in indexPaths {
            cancelDownload(at: indexPath.row)
        }
    }
}

extension PrefetchingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let imageView = cell.viewWithTag(100) as? UIImageView {
            if let image = list[indexPath.row].image {
                imageView.image = image
            } else {
                imageView.image = nil
                downloadImage(at: indexPath.row)
            }
        }
        
        if let label = cell.viewWithTag(200) as? UILabel {
            label.text = "#\(indexPath.row + 1)"
        }
        
        return cell
    }
}




extension PrefetchingViewController {
    // 이미지 다운로드
    func downloadImage(at index: Int) {
        // 다운로드된 이미지가 있나? 있다면 다운받을 필요 없으니까
        guard list[index].image == nil else {
            return
        }
        
        // 동일한 이미지를 다운로드받고있는 작업이 존재하는지? 중복 다운로드 방지
        // 따라서 동일한 인덱스에서 연속적으로 다운로드 메서드를 호출해도 불필요한 작업이 이루어지지 않는다
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
                    if strongSelf.listTableView.indexPathsForVisibleRows?.contains(reloadTargetIndexPath) == .some(true) {
                        strongSelf.listTableView.reloadRows(at: [reloadTargetIndexPath], with: .automatic)
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
