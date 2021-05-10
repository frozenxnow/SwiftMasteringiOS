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

class MultilineLabelViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var lineNumberLabel: UILabel!
    @IBOutlet weak var lineNumberStepper: UIStepper!
    @IBOutlet weak var autoshrinkSwitch: UISwitch!
    @IBOutlet weak var lineBreakModePicker: UIPickerView!
    
    
    
    @IBAction func updateLines(_ sender: UIStepper) {
        sender.minimumValue = 1
        valueLabel.numberOfLines = Int(sender.value)
        lineNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func toggleAutoshrink(_ sender: UISwitch) {
        valueLabel.minimumScaleFactor = sender.isOn ? 0.5 : 0.0
        valueLabel.adjustsFontSizeToFitWidth = sender.isOn
        
    }
    
    func changeLineBreakMode(with rawValue: Int) {
        if let mode = NSLineBreakMode(rawValue: rawValue) {
            valueLabel.lineBreakMode = mode
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineNumberLabel.text = "\(valueLabel.numberOfLines)"
        lineNumberStepper.value = Double(valueLabel.numberOfLines)
        
        autoshrinkSwitch.isOn = valueLabel.minimumScaleFactor != 0 && valueLabel.adjustsFontSizeToFitWidth
        
        lineBreakModePicker.selectRow(valueLabel.lineBreakMode.rawValue, inComponent: 0, animated: false)
        
    }
}

extension MultilineLabelViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
}

extension MultilineLabelViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Word Wrap"
        case 1:
            return "Character Wrap"
        case 2:
            return "Clip"
        case 3:
            return "Truncating Head"
        case 4:
            return "Truncating Tail"
        case 5:
            return "Truncating Middle"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeLineBreakMode(with: row)
    }
}
