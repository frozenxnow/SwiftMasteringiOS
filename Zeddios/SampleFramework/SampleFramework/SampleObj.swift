//
//  SampleObj.swift
//  SampleFramework
//
//  Created by 지원 on 2021/08/08.
//

import Foundation
import UIKit

open class SampleObj: NSObject {
    open func openFunc() {
        self.hideFunc()
    }
    
    func hideFunc() {
        print(#function)
    }
}



