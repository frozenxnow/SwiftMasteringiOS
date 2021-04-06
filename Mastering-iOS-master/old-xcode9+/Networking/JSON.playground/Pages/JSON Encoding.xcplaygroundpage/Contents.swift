import UIKit

struct Person: Codable {
   var firstName: String
   var lastName: String
   var birthDate: Date
   var address: String?
}

let p = Person(firstName: "John", lastName: "Doe", birthDate: Date(timeIntervalSince1970: 1234567), address: "Seoul")

//
let encoding = JSONEncoder()
encoding.outputFormatting = .prettyPrinted

do {
    let jsonData = try encoding.encode(p)
    
    if let jsonStr = String(data: jsonData, encoding: .utf8) {
        
        print(jsonStr)
    }

} catch {
    print(error)
}
//


//: [Next](@next)
