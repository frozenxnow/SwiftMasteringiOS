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

class StackViewArrangedSubviewsViewController: UIViewController {
   
   @IBOutlet weak var stackView: UIStackView!
   
   @IBAction func add(_ sender: Any) {
    let v = generateView()
      // 새로운 arranged subview 생성
    stackView.addArrangedSubview(v)
    // 배열의 끝(오른쪽)에 arrangesubview에 추가
    
   }
   
   @IBAction func insert(_ sender: Any) {
      let v = generateView()
    stackView.insertArrangedSubview(v, at: 0)
    // 배열의 처음(왼쪽)에 arrangesubview에 추가
   }
   
   @IBAction func remove(_ sender: Any) {
      // 배열이 비어있는지 확인
    guard stackView.arrangedSubviews.count > 0 else { return }
    
    // 배열이 비어있지 않다면 인덱스의 랜덤 값을 구해
    let index = Int.random(in: 0..<stackView.arrangedSubviews.count)
    // 랜덤 view를 삭제
    let v = stackView.arrangedSubviews[index]
    stackView.removeArrangedSubview(v)
   }
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}

extension StackViewArrangedSubviewsViewController {
   private func generateView() -> UIView {
      let v = UIView()
      
      let r = CGFloat(arc4random_uniform(256)) / 255
      let g = CGFloat(arc4random_uniform(256)) / 255
      let b = CGFloat(arc4random_uniform(256)) / 255
      v.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
      // random color를 background에 넣어 return
      return v
   }
}
