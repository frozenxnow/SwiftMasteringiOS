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

class ImagePickerViewController: UIViewController {
    
    lazy var images: [UIImage] = {
        return (0...6).compactMap { UIImage(named: "slot-machine-\($0)") }
    }()
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func shuffle(_ sender: Any?) {
        // 1번, 3번. 셔플 버튼을 누르면 랜덤으로 중간 바퀴의 그림이 랜덤으로 나옴
        // 이미지는 총 7개. 첫,마지막 그림이 선택될 경우 위아래가 끊기기 때문에 중간 바퀴에 있는 그림에서 나와야함
        let firstIndex = Int.random(in: 0..<images.count) + images.count
        let secondIndex = Int.random(in: 0..<images.count) + images.count
        let thirdIndex = Int.random(in: 0..<images.count) + images.count
        
        // pickerView에서 특정한 항목을 선택하는 함수
        picker.selectRow(firstIndex, inComponent: 0, animated: true)
        picker.selectRow(secondIndex, inComponent: 1, animated: true)
        picker.selectRow(thirdIndex, inComponent: 2, animated: true)
        
        // 세개가 일치하면 게임이 끝나는 알림창 띄우기
        let alert = UIAlertController(title: "잭팟ㅋ", message: "ㅊㅋㅊㅋ!!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        if firstIndex==secondIndex && secondIndex == thirdIndex {
            present(alert, animated: false, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 3. 터치 이벤트 비활성화
        picker.isUserInteractionEnabled = false
        
        // 첫 선택 이미지를 두번째 바퀴의 첫 그림으로 설정(내가 하고싶어서 함ㅋ)
        picker.selectRow(images.count, inComponent: 0, animated: true)
        picker.selectRow(images.count, inComponent: 1, animated: true)
        picker.selectRow(images.count, inComponent: 2, animated: true)
    }
}

extension ImagePickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count * 3 // 무한 스크롤 효과
    }
}

extension ImagePickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // 상대적으로 사이즈가 큰 이미지뷰는 만들어 둔 이미지뷰가 있으면 그것을 재사용하는데 이것은 마지막 파라미터(view)로 전달된다
        // 재사용 하는 방법은 아래와 같이 UIImageView 타입의 view가 있다면 그것을 재사용(리턴)
        if let imageView = view as? UIImageView {
            imageView.image = images[row % images.count]
            return imageView
        }
        // 만약 만들어둔 이미지뷰가 없다면 새로 생성한다. 얘를 나중에 다시 쓰게되면 그때 view로 전달된다
        let imageView = UIImageView()
        imageView.image = images[row % images.count]
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        // 2. 이미지 사이즈 조절
        return 60
    }
    
    // 여기까지 생성한 후 개선할 점을 찾아본다
    // 1. 시작점을 첫 데이터가 아닌 중간 데이터(두번째 바퀴의 첫 데이터)로 설정
    // 2. 이미지 사이즈 조절
    // 3. 슬롯머신은 아래의 셔플을 눌렀을때 실행되도록 함(사용자가 슬롯을 직접 돌리지 못하게 비활성화)
}


