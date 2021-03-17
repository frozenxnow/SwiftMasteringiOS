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


class DispatchQueueViewController: UIViewController {
   
   @IBOutlet weak var valueLabel: UILabel!

   
   
   @IBAction func basicPattern(_ sender: Any) {
      var total = 0
      for num in 1...100 {
         total += num
         Thread.sleep(forTimeInterval: 0.1)
      }

      valueLabel.text = "\(total)"
   }
   
   @IBAction func sync(_ sender: Any) {
      
   }
   
   @IBAction func async(_ sender: Any) {
      
   }
   
   @IBAction func delay(_ sender: Any) {
      
   }
   
   @IBAction func concurrentIteration(_ sender: Any) {
      
   }
}
























