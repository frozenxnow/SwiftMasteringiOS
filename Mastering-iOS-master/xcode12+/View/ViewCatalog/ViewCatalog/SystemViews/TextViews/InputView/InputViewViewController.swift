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


class InputViewViewController: UIViewController {
    
    @IBOutlet var pickerContainerView: UIView!
    
    @IBOutlet var buttonContainerView: UIView!
    
    @IBOutlet var accessoryBar: UIToolbar!
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBAction func selectGender(_ sender: UIButton) {
        genderField.text = sender.tag == 0 ? "M" : "F"
        
        UIDevice.current.playInputClick()
        
    }
    
    @IBAction func movePrevious(_ sender: Any) {
        
        if genderField.isFirstResponder {
            ageField.becomeFirstResponder()
        } else if ageField.isFirstResponder {
            nameField.becomeFirstResponder()
        }
        
    }
    
    @IBAction func moveNext(_ sender: Any) {
        if nameField.isFirstResponder {
            ageField.becomeFirstResponder()
        } else if ageField.isFirstResponder {
            genderField.becomeFirstResponder()
        }
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageField.inputView = pickerContainerView
        genderField.inputView = buttonContainerView
        nameField.inputAccessoryView = accessoryBar
        ageField.inputAccessoryView = accessoryBar
        genderField.inputAccessoryView = accessoryBar
    }
}


class GenderInputView: UIView, UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool {
        return true
    }
}



extension InputViewViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
}

extension InputViewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageField.text = "\(row+1)"
    }
}












