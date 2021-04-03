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
import CoreGraphics

class ImageResizingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let image = UIImage(named: "photo") {
//            let size = CGSize(width: image.size.width / 5.0, height: image.size.height / 5.0)
//            imageView.image = resizingWithImageContext(image: image, to: size)
//        }
        
        if let image = UIImage(named: "photo") {
            let size = CGSize(width: image.size.width / 5.0, height: image.size.height / 5.0)
            imageView.image = resizingWithBitmapContext(image: image, to: size)
        }
                
    }
}




extension ImageResizingViewController {
    func resizingWithImageContext(image: UIImage, to size: CGSize) -> UIImage? {
        
        // 1. 컨텍스트를 생성한다
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        // 2. 프레임을 생성한다
        let frame = CGRect(origin: CGPoint.zero, size: size)
        // 3. 프레임에 그림을 그린다
        image.draw(in: frame)
        // 4. 컨텍스트에 있는 그림을 실제로 사용할 수 있도록 꺼낸다
        let img = UIGraphicsGetImageFromCurrentImageContext()
        // 5. 컨텍스트를 해제한다
        UIGraphicsEndImageContext()
        
        return img
    }
}

extension ImageResizingViewController {
    func resizingWithBitmapContext(image: UIImage, to size: CGSize) -> UIImage? {
        
        // 1. 비트맵을 사용하기 위해 cgImage(coreGraphicsImage)로 변경한다
        guard let cgImage = image.cgImage else {
            return nil
        }
        
//        let bpc = cgImage.bitsPerComponent
//        let bpr = cgImage.bytesPerRow
//        let colorSpace = cgImage.colorSpace!
//        let bitmapInfo = cgImage.bitmapInfo
        
        // 2. 비트맵 컨텍스트를 생성한다
        guard let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: cgImage.bytesPerRow, space:  cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue) else {
            return nil
        }
        
        // 3. 이미지의 품질을 설정한다
        context.interpolationQuality = .high
        
        // 4. 프레임을 생성한다
        let frame = CGRect(origin: CGPoint.zero, size: size)
        
        // 5. 프레임에 그림을 그린다 (CGContext에 구현된 메서드로 앞서 사용한 메서드와 완전히 다르다)
        context.draw(cgImage, in: frame)
        
        // 6. 컨텍스트에 그려진 이미지를 실제 이미지로 변경한다
        guard let img = context.makeImage() else {
            return nil
        }
        
        // 7. CGImage를 UIImage로 변경하여 리턴한다
        return UIImage(cgImage: img)
        
    }
}













