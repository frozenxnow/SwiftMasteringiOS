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

import Foundation

/*:
 # Date Calculation
 */

extension Date {
    init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, calendar: Calendar = .current) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.day = day
        
        guard let date = calendar.date(from: components) else {
            return nil
        }
        
        self = date
    }
}

let calendar = Calendar.current
let worldCup2002 = Date(year: 2002, month: 5, day: 31)!

let now = Date()
let today = calendar.startOfDay(for: now) // 0시0분0초로 만들어줌

var comps = DateComponents()
comps.day = 100

calendar.date(byAdding: comps, to: now)
calendar.date(byAdding: comps, to: today)

//2002 월드컵으로부터 며칠이 지났는지?
comps = calendar.dateComponents([.day], from: worldCup2002, to: today)
comps.day
//: [Next](@next)
