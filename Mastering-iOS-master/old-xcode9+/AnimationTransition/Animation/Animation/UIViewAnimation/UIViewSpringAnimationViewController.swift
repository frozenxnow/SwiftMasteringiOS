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

class UIViewSpringAnimationViewController: UIViewController {
   
   @IBOutlet weak var redView: UIView!
   
   @IBOutlet weak var dampingSlider: UISlider!
   @IBOutlet weak var velocitySlider: UISlider!
   
   @IBAction func reset(_ sender: Any?) {
      redView.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
   }
   
   @IBAction func animate(_ sender: Any) {
      let targetFrame = CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200)
    
    UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: CGFloat(dampingSlider.value), initialSpringVelocity: CGFloat(velocitySlider.value), options: [], animations: {
        self.redView.frame = targetFrame
    }, completion: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      reset(nil)
   }
}













