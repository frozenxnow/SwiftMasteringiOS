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
//: [Previous](@previous)

/*:
 # DateComponentsFormatter
 */
import Foundation

let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 30)


let formatter = DateComponentsFormatter()
formatter.unitsStyle = .full

if let result = formatter.string(from: startDate, to: endDate) {
    print(result)
}

var comps = DateComponents()
comps.day = 0
comps.hour = 1
comps.minute = 0
comps.second = 7

formatter.unitsStyle = .positional
formatter.zeroFormattingBehavior = .dropAll

//formatter.allowedUnits = [.minute]
//formatter.maximumUnitCount = 1 // 작은 단위부터 생략, 반올림된다
//formatter.includesTimeRemainingPhrase = true
//formatter.includesApproximationPhrase = true

if let result = formatter.string(from: comps) {
    print(result)
}


//: [Next](@next)
