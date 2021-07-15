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

class SplitVCHostViewController: UIViewController {
   @IBAction func presentSplitViewController(_ sender: Any) {
      // masterVC, detailVC는 스토리보드 id를 사용해 생성한다
//    if #available(iOS 13.0, *) {
//        guard let masterVC = storyboard?.instantiateViewController(identifier: "ColorListTableViewController") else { return }
//    }
//    let nav = UINavigationController(rootViewController:masterVC)
//
//    if #available(iOS 13.0, *) {
//        guard let detailVC = storyboard?.instantiateViewController(identifier: "ColorDetailViewController") else { return }
//    }
//    let splitVC = CustomSplitViewController()
//    splitVC.viewControllers = [nav, detailVC]
    
//    present(splitVC, animated: true, completion: nil)
   }
   
   @IBAction func unwindToSplitHost(_ sender: UIStoryboardSegue) {
      
   }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CustomSplitViewController {
            vc.setupDefaultValue()
        }
    }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
}





























