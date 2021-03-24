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

class TextPickerViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func report(_ sender: Any) {
        
//        let row = picker.selectedRow(inComponent: 0)
//        guard row >= 0 else {
//            print("not found")
//            return
//        }
//
//        print(devTools[row])
        
        let fruitSelectedRow = picker.selectedRow(inComponent: 0)
        let devToolsSelectedRow = picker.selectedRow(inComponent: 0)
        guard fruitSelectedRow >= 0 && devToolsSelectedRow >= 0 else {
            print("not found")
            return
        }
        print(fruits[fruitSelectedRow], devTools[devToolsSelectedRow])
        
        // 피커뷰에서 항목 선택 후 다른 이벤트가 발생한 다음 이루어져야하는 액션은 이렇게 구현한다
        
    }
    let devTools = ["Xcode", "Postman", "SourceTree", "Zeplin", "Android Studio", "SublimeText"]
    let fruits = ["Apple", "Orange", "Banana", "Kiwi", "Watermelon", "Peach", "Strawberry"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TextPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // 휠의 수 리턴
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return devTools.count // 선택지 수 리턴
        case 1:
            return fruits.count
        default:
            return 0
        }
    }
}


extension TextPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return devTools[row] // 선택지 내용 리턴
        case 1:
            return fruits[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            label.text = devTools[row]
            return
        case 1:
            label.text = fruits[row]
            return
        default:
            return
        }
        // 항목을 선택하자마자 일어나는 이벤트를 처리하는 방법에는 이 메서드를 사용함
    }

}




