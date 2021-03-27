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

class SimpleSliderViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    @IBAction func colorChanged(_ sender: Any) {
        
        let r = CGFloat(redSlider.value)
        // UI값으로 사용할 때에는 CGFloat값으로 바꾸어야합니다.
        let g = CGFloat(greenSlider.value)
        let b = CGFloat(blueSlider.value)
        
        let newColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        view.backgroundColor = newColor
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        redSlider.value = 1.0
//        greenSlider.value = 1.0
//        blueSlider.value = 1.0
        
        redSlider.setValue(0.5, animated: true)
        greenSlider.setValue(0.5, animated: true)
        blueSlider.setValue(0.5, animated: true)
        
    }
}
