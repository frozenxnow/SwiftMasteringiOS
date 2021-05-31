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

class ViewManagementViewController: UIViewController {
   
   var grayView: UIView?
    
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var greenView: UIView!
    
    @IBOutlet weak var blueView: UIView!
    
    
   func addRandomView() {
      let v  = generateRandomView()
      view.addSubview(v)
    // 이렇게 추가할 경우 v가 루트뷰에 subView 배열 중 가장 마지막에 추가
   }
   
   func insertRandomViewToBack() {
    // 특정 위치에 view 추가
        let v = generateRandomView()
        view.insertSubview(v, at: 0) // 가장 마지막에 추가하려면 index =.
   }
   
   func removeTopmostRandomView() {
    let topmostRandomView = view.subviews.reversed().first { $0.tag > 0 } // 가장 위에 있는, 배열의 가장 마지막 뷰 제거
    topmostRandomView?.removeFromSuperview()
   }
   
   func bringRedViewToFront() {
      // 서브뷰의 순서를 바꾸는 메서드, 슈퍼뷰에서 호출
    view.bringSubview(toFront: redView) // redView를 가장 앞으로 이동하게 함, subViews 배열에서는 가장 마지막
   }
   
   func sendRedViewToBack() {
    view.sendSubview(toBack: redView)
   }
   
   func switchGreenViewWithBlueView() {
    // subView의 위치를 교차
    guard let greenViewIndex = view.subviews.index(of: greenView) else { return }
    guard let blueViewIndex = view.subviews.index(of: blueView) else { return }
    view.exchangeSubview(at: greenViewIndex, withSubviewAt: blueViewIndex)
   }
   
   func addGrayViewToRedView() {
       grayView = generateGrayView()
    // redView에 grayView를 추가하기 때문에 루트뷰가 아닌 레드뷰에서 호출
    redView.addSubview(grayView!)
   }
   
   func moveGrayViewToRootView() {
    if let grayView = grayView {
        view.addSubview(grayView)
        // 레드뷰에 추가된 그레이뷰를 루트뷰에 추가한다. 그레이뷰가 레드뷰에서 제거, 루트뷰에 추가된다
    }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
    // navi에 버튼을 추가
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
   }
}



extension ViewManagementViewController {
   @objc func showMenu() {
      let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      let addRandomViewAction = UIAlertAction(title: "Add Random View", style: .default) { [weak self] (action) in
         self?.addRandomView()
      }
      menu.addAction(addRandomViewAction)
      
      let insertRandomViewToBackAction = UIAlertAction(title: "Insert Random View to Back", style: .default) { [weak self] (action) in
         self?.insertRandomViewToBack()
      }
      menu.addAction(insertRandomViewToBackAction)
      
      let removeTopmostRandomViewAction = UIAlertAction(title: "Remove Topmost Random View", style: .default) { [weak self] (action) in
         self?.removeTopmostRandomView()
      }
      menu.addAction(removeTopmostRandomViewAction)
      
      let bringRedViewToFrontAction = UIAlertAction(title: "Bring Red View to Front", style: .default) { [weak self] (action) in
         self?.bringRedViewToFront()
      }
      menu.addAction(bringRedViewToFrontAction)
      
      let sendRedViewToBackAction = UIAlertAction(title: "Send Red View to Back", style: .default) { [weak self] (action) in
         self?.sendRedViewToBack()
      }
      menu.addAction(sendRedViewToBackAction)
      
      let switchGreenViewWithBlueViewAction = UIAlertAction(title: "Switch Green View with Blue View", style: .default) { [weak self] (action) in
         self?.switchGreenViewWithBlueView()
      }
      menu.addAction(switchGreenViewWithBlueViewAction)
      
      let addGrayViewToRedViewAction = UIAlertAction(title: "Add Gray View to Red View", style: .default) { [weak self] (action) in
         self?.addGrayViewToRedView()
      }
      menu.addAction(addGrayViewToRedViewAction)
      
      let moveGrayViewToRootViewAction = UIAlertAction(title: "Move Gray View to Root View", style: .default) { [weak self] (action) in
         self?.moveGrayViewToRootView()
      }
      menu.addAction(moveGrayViewToRootViewAction)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      menu.addAction(cancelAction)
      
      present(menu, animated: true, completion: nil)
   }
   
    // 새로운 뷰를 생성하는 메서드
   func generateRandomView() -> UIView {
      let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
      let v = UIView(frame: frame)
      v.center = view.center
      v.backgroundColor = UIColor.random
      v.tag = Int(arc4random_uniform(UInt32(Int16.max)) + 1)
      
      return v
   }
   
   func generateGrayView() -> UIView {
      let frame = CGRect(x: 100, y: 100, width: 50, height: 50)
      let v = UIView(frame: frame)
      v.backgroundColor = UIColor.gray
      
      return v
   }
}



extension UIColor {
   static var random: UIColor {
      let r = CGFloat(arc4random_uniform(256)) / 255
      let g = CGFloat(arc4random_uniform(256)) / 255
      let b = CGFloat(arc4random_uniform(256)) / 255
      
      return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
   }
}


















