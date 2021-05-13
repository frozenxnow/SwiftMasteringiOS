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

class TextDelegateViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    
    lazy var charSet = CharacterSet(charactersIn: "0123456789").inverted
    lazy var genderCharSet = CharacterSet(charactersIn: "MF").inverted
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.becomeFirstResponder()
        
    }
}

extension TextDelegateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            ageField.becomeFirstResponder()
        case ageField:
            genderField.becomeFirstResponder()
        case genderField:
            emailField.becomeFirstResponder()
        case emailField:
            emailField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("current: \(textField.text ?? "")")
        print("string: \(string)")
        
        let currentText = NSString(string: textField.text ?? "")
        let finalText = currentText.replacingCharacters(in: range, with: string)
        switch textField {
        case nameField:
            if finalText.count > 10 {
                return false
            }
        case ageField:
            // charSet에는 숫자를 제외한 모든 문자가 포함되어 있다
            if let _ = string.rangeOfCharacter(from: charSet) {
                // string에 입력된 값이 숫자가 아닐 경우(charSet에 포함될 경우: 숫자가 아님)
                return false
            }
            
            if let age = Int(finalText), !(1...100).contains(age) {
                return false
            }
        case genderField:
            if finalText.count > 1 {
                return false
            }
            if let _ = string.rangeOfCharacter(from: genderCharSet) {
                return false
            }
        
        default:
            break
        }
        
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            if let email = textField.text {
                guard let _ = email.range(of: regex, options: .regularExpression) else {
                    alert(message: "Invalid Email")
                    return false
                }
            }
        }
        
        return true
    }
}



// 경고창을 띄우는 method
extension TextDelegateViewController {
    func alert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

















