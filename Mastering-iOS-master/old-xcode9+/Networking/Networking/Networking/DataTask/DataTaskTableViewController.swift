//
//  Copyright (c) 2018 KxCoding <kky0317@gmail.com>
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

class DataTaskTableViewController: UITableViewController {
   
   var list = [Book]()
   
   @IBAction func sendRequest(_ sender: Any) {
      let booksUrlStr = "https://kxcoding-study.azurewebsites.net/api/books"
      
      // Code Input Point #1
    guard let url = URL(string: booksUrlStr) else {
        fatalError("Invalid URL")
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: url) { (data, response, error) in
        // 1) 에러 검증
        if let error = error {
            self.showErrorAlert(with: error.localizedDescription)
            return
        }
        // 2) response
        
        guard let httpResponse = response as? HTTPURLResponse else {
            self.showErrorAlert(with: "Response Error")
            return
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            self.showErrorAlert(with: "Connect Error")
            return
        }
        
        // 3) data
        guard let data = data else {
            self.showErrorAlert(with: "data Error")
            return
        }
        
        // 디코딩
        do {
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
                
                let date = formatter.date(from: dateStr)!
                
                return date
                
                
            })
            
            let bookList = try decoder.decode(BookList.self, from: data)
            
            if bookList.code == 200 {
                self.list = bookList.list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            self.showErrorAlert(with: "Error")
            return
        }
    }

    task.resume()
   
      // Code Input Point #1
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let destVC = segue.destination as? BookDetailTableViewController {
         if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Code Input Point #5 다음 페이지로 전달할 것
            destVC.book = list[indexPath.row]
            // Code Input Point #5
         }
      }
   }
}

extension DataTaskTableViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      // Code Input Point #2
    let target = list[indexPath.row]
    cell.textLabel?.text = target.title
      // Code Input Point #2
      
      return cell
   }
}
