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
import AVFoundation

class LandscapeModalViewController: UIViewController {

   @IBOutlet weak var closeButton: UIButton!
   @IBOutlet weak var playerView: PlayerView!
   
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // Rotation 이벤트가 일어날 때마다 버튼 뒤의 배경을 토글하는 메서드 구현
        super.willTransition(to: newCollection, with: coordinator)
        
        // portrait 가로, 세로 길이로 대략적으로 파악한다
        print(newCollection.verticalSizeClass.description)
        
        // size class가 regular면 red background color, 나머지 green : 아이패드에서 적용되지 않는다
        switch newCollection.verticalSizeClass {
        case .regular:
            closeButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        default: // Compact
            closeButton.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        }
    }
    
    // RootView Size Update 전 호출, 첫번째 파라미터를 사용해 가로인지 세로인지 파악
    // iPad에서도 동작할 수 있도록 이 메서드를 추가한다
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            if size.height > size.width { // 세로
                self.closeButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            } else {
                self.closeButton.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            }
        }, completion: nil)
    }
    
   override func viewDidLoad() {
      super.viewDidLoad()
      
      guard let url = Bundle.main.url(forResource: "video", withExtension: "mp4") else { return }
      let player = AVPlayer(url: url)
      playerView.player = player
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      playerView.player?.play()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      playerView.player?.pause()
   }
   
   
}



extension UIUserInterfaceSizeClass {
   var description: String {
      switch self {
      case .compact:
         return "Compact"
      case .regular:
         return "Regular"
      default:
         return "Unspecified"
      }
   }
}
















