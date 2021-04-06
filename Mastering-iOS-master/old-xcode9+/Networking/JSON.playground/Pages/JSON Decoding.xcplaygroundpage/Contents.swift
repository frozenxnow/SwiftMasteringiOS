//: [Previous](@previous)

import Foundation

struct Person: Codable {
   var firstName: String
   var lastName: String
   var age: Int
   var address: String?
}

let jsonStr = """
{
"firstName" : "John",
"age" : 30,
"lastName" : "Doe",
"address" : "Seoul"
}
"""

guard let jsonData = jsonStr.data(using: .utf8) else {
   fatalError()
}

//
let decoder = JSONDecoder()

do {
    let decodedData = try decoder.decode(Person.self, from: jsonData)
    dump(decodedData)
} catch {
    print(error)
}
//


//: [Next](@next)
