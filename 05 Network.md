# Network

# 1. Network Overview

데이터가 내부, 외부를 오가기 때문에 더욱 어렵습니다. 특히 모바일에서는 IP 주소가 바뀌거나 네트워크 인터페이스가 바뀌는 경우가 상당히 많습니다. (wifi, cellular) 

보안도 매우 중요합니다. 

애플에서 제시한 가이드라인

1. `Use High-Level APIs` : 낮은 레벨은 프레임워크가 기본적으로 제공하는 보안 기능을 사용하지 못합니다.
2. `Transfer only as much data as required` 
3. `Use Caches`
4. `Use Asynchronous APIs` (비동기 API 사용해야합니다) : 비동기를 사용하려면 background-thread를 사용합니다. 메인쓰레드에서 진행할 경우 메인쓰레드가 블로킹되는 시간이 길어지기 때문에 background에서 작업을 진행합니다. 
5. `Use Hostnames` : 네트워크를 요청할 때에는 반드시 Hostname으로 요청합니다.
6. `Use HTTPS` ( X HTTP X )

네트워크를 통해 데이터를 요청할 때에는 URL 인스턴스가 필요합니다.

```jsx
guard let url = URL(string: picUrlStr) else {
    fatalError("Invalid URL")
}

let task = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
    if let error = error {
        print(error)
    } else if let data = data {
        let image = UIImage(data: data)
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
task.resume()
```

# 2. Displaying Web Contents

Label을 추가할 때 WebView와 WebKitView가 있는데 WebView는 더 이상 사용하지 않습니다. WebKitView를 화면에 추가하고 툴바와 url을 입력할 수 있는 textField, 하단 툴바와 뒤로가기, 새로고침, 앞으로가기의 버튼을 생성했습니다. 

textField와 WebView는 @IBOutlet으로, 각 버튼들은 @IBAction으로 연결했습니다.

여기에서 중요한 것은 textField는 ViewController(WebContents)를 delegator로 지정합니다. 

1) override func viewDidLoad()

우선 첫 화면으로 "http://www.apple.com"을 띄우기 위해 textField에 자동으로 입력될 값을 작성합니다. 

```jsx
override func viewDidLoad() {
  super.viewDidLoad()
  
  navigationItem.largeTitleDisplayMode = .never
  webView.navigationDelegate = self
  
	urlField.text = "http://www.apple.com"
	}
}
```

2) func go(to urlStr: String)

해당 페이지로 이동하는 메서드입니다. url 인스턴스를 생성하고, url request 인스턴스를 생성한 후 webView에서 load 하는 과정이 필요합니다. 

```jsx
func go(to urlStr: String) {
    guard let url = URL(string: urlStr) else {
        fatalError("Invalid URL")
    } // url 인스턴스 생성 
    let request = URLRequest(url: url) // url Request 인스턴스 생성
    webView.load(request) // webView에 요청된 내용을 띄운다
}
```

 지정된 url에서 요청에 의해 html을 다운받아 webView에 띄우는 과정입니다. 

3) 각 버튼을 구현합니다.

```jsx
@IBAction func goBack(_ sender: Any) {
		if webView.canGoBack {
		    webView.goBack()
		}
}

@IBAction func reload(_ sender: Any) {
		webView.reload()
}

@IBAction func goForward(_ sender: Any) {
		if webView.canGoForward {
		    webView.goForward()
		}
}
```

# 3. App Transport Security

ATS는 애플에서 제공하는 보안 기능으로 안전하지 않은 연결은 접속을 허용하지 않습니다. 예를들면 https:// 로 시작하는 페이지의 경우는 접속을 허용하지만, http:// 로 시작하는 페이지는 보안이 취약하여 연결되지 않습니다.

[http://www.apple.com](http://www.apple.com) 웹사이트의 경우에는 접속이 가능합니다. 이는 ATS setting을 변경해주었기 때문에 접속이 허용되어있습니다. 

1) Info.plist > add row > Allow Arbitary Loads를 ture로 설정하는 방법

- 권유하지 않습니다. 이는 ATS의 모든 보안기능을 무력화하기 때문에 보안에 매우 취약한 상태입니다.

2) Info.plist > add row > Allow Arbitary Loads 에서 속성 추가

- Exception Domains : [daum.net](http://daum.net) (type: Dictionary)
    - NSExceptionAlowsInsecureHTTPLoads: true ( http 연결을 허용합니다 )
    - NSIncludesSubdomains: true ( daum.net을 포함한 서브 페이지도 연결을 허용합니다)

위의 두 방법 중 아래의 방법을 권장하긴 하나 이러한 방법은 특별히 필요할 때가 아니면 사용하지 않는 것이 좋습니다.

# 4. JSON #1

JSON(JavaScript Object Notation)은 네트워크를 통해 데이터를 주고받을 때 사용하는 개방형 표준 포맷입니다. 일단 {} 으로 싸여있는 큰 Swift Dictionary 형태이고, 그 내부에는 Array가 있고, 각 Array에는 개별Dictionary가 Key-Value를 저장하고 있습니다.

JSON을 사용하기 위해서는 인코딩과 디코딩을 알고 있어야 합니다.

- 인코딩이란 모든 형식의 데이터를 JSON 포맷으로 변경하는 작업이며 인코더를 사용하기 위해서는 데이터가 Encodable 프로토콜을 채용하고 있어야 합니다.
- 디코딩은 그 반대로 JSON에 저장된 데이터를 인스턴스로 반환하며 Decodable 프로토콜을 채용하고 있어야 합니다.
- 만약 Encoding, Decoding이 모두 가능하다면 Codable 프로토콜로 대체할 수 있습니다.

## Encoding

인코더를 사용하기 위해서는 인코더 인스턴스를 생성해야합니다. 인코더 인스턴스를 생성한 뒤 인코드 메서드를 호출해 필요한 데이터를 JSON 포맷 형태로 변경합니다.

```jsx
// 0. Codable 프로토콜 채용
struct Person: Codable {
   var firstName: String
   var lastName: String
   var birthDate: Date
   var address: String?
}

let p = Person(firstName: "John", lastName: "Doe", birthDate: Date(timeIntervalSince1970: 1234567), address: "Seoul")

// 1. 인코더 인스턴스 생성
let encoder = JSONEncoder()

// 2. 인코드 메서드 호출 (do-catch 사용)
do {
    let jsonData = try encoder.encode(p)
} catch {
    print(error)
}
```

여기에서 인코더로 변환된 데이터 jsonData를 출력하면 JSON(SwiftDictionary) 형태를 binary 문자로 출력합니다. 보통 서버로 전달할 때는 binary 형태로 전달하기 때문입니다. 이를 콘솔에 출력하기 위해 문자열로 변환하는 코드를 추가합니다.

```jsx
do {
    let jsonData = try encoder.encode(p)
    
    if let jsonStr = String(data: jsonData, encoding: .utf8) {
        print(jsonStr)
    }

} catch {
    print(error)
}
```

콘솔을 보면 데이터는 올바르게 출력되었으나 우리가 보통 볼 수 있는 구조의 JSON 데이터가 아닙니다. 한 줄로 나란히 쓰여진 가독성이 낮은 데이터이므로 줄바꿈 옵션을 추가합니다. 인코더 인스턴스에서 옵션을 변경합니다. 

```jsx
encoder.outputFormatting = .prettyPrinted
```

속성 이름은 주로 lowerCamelCase로 작성합니다. encoder의 속성을 통해 이 포맷도 변경할 수 있습니다. 

```jsx
encoder.keyEncodingStrategy = .convertToSnakeCase
```

이렇게 변경할 경우 lowerCamelCase형태는 SnakeCase로 바뀌는데, 이는 모든 문자를 소문자로 변경하고 단어와 단어 사이를 언더바로 연결합니다.

Date 속성은 정수 단위로 출력됩니다. 이는 해당 Date부터 지금 사이의 시간을 초단위로 계산하여 출력하기 때문에 encoder의 속성에 접근해 포맷을 변경할 수 있습니다. 

```jsx
encoder.dateEncodingStrategy = .iso8601
```

일반적으로 사용하는 표준 Date의 패턴은 iso8601 타입입니다. 사용자 정의 포맷으로도 출력이 가능합니다.

```jsx
let formatter = DateFormatter()
formatter.dateFormat = "yyyy/MM/dd"
encoder.dateEncodingStrategy = .formatted(formatter)
```

## Decoding

디코더를 사용하기 위해서는 디코더 인스턴스를 생성해야합니다. 디코더 인스턴스를 생성한 뒤 디코드 메서드를 호출해 파라미터로 데이터의 타입과 변환할 JSON 데이터를 파라미터로 전달합니다. 

```jsx
// 0. Codable 프로토콜 채용
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

// 1. 디코더 인스턴스 생성 
let decoder = JSONDecoder()

// 2. 디코드 메서드 호출 (변경하고자 하는 인스턴스 타입, 변경하고자 하는 JSON데이터)
do {
    let decodedData = try decoder.decode(Person.self, from: jsonData)
    dump(decodedData)
} catch {
    print(error)
}
```

디코딩할 때에는 구조체의 속성 이름과 JSON 데이터의 키값이 일치해야 하고 그 타입도 일치해야합니다. 하나라도 다를 경우 옵셔널 타입의 경우 nil을 리턴하지만 그게 아니라면 에러가 발생합니다. 만약 구조체에서는 lowerCamelCase로 작성되어 있고 JSON 데이터에서는 snake_case로 작성되어 있을 경우 에러가 발생하기 때문에 둘 중 하나의 이름을 변경해야합니다. 

```jsx
decoder.keyDecodingStrategy = .convertFromSnakeCase
```

인코딩 시 사용했던 것은 convertToSnakeCase 였고, 디코딩에서 사용하는 케이스는 convertFromSnakeCase입니다. 디코딩하는 자료(snake_case)로부터 케이스를 lowerCamelCase로 변경하는 코드입니다.

```jsx
let jsonStr = """
{
"name" : "iPad Pro",
"releaseDate" : "2018-10-30T23:00:00Z"
}
"""
```

별도의 decodingStrategy를 설정하지 않으면 date는 double 값으로 디코딩을 시도합니다. 위 JSON 데이터에서 시간은 iso8601 표준문자열로 저장되어 있습니다. 이 문자열을 double 형태로 바꿀 수 없기 때문에 별도로 처리해주지 않고 디코딩을 시도할 경우 에러가 발생합니다.

```jsx
decoder.dateDecodingStrategy = .iso8601
```

위 코드를 추가할 경우 ios8601의 형식으로 date가 처리됩니다. 반대로 double 값으로 처리하도록 해도 오류 없이 해결이 가능하지만 가독성이 떨어지기 때문에 보통은 위와 같이 표준 문자열로 처리하도록 권장합니다.

# 5. JSON #2

## Custom Key Mapping

Encoding할 때에는 구조체의 속성과 데이터의 키 값이 일치해야 올바른 인코딩이 이루어집니다. 서로 다른 이름의 속성과 키값을 연결하기 위해서는 열거형의 rawValue를 사용합니다.

```jsx
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
"homeAddress" : "Seoul",
}
"""
```

만약 jsonStr를 인코딩하기 위해서는 homeAddress를 Person 구조체의 address 이름으로 매핑해야합니다.

구조체 안에 새로운 이름의 열거형을 선언하고, 각 케이스는 속성값과 동일하게 정의합니다. 그리고 그 열거형은 String형태의 rawValue를 가지고 있고 Coding Key 프로토콜을 채용해야합니다.

```jsx
struct Person: Codable {
   var firstName: String
   var lastName: String
   var age: Int
   var address: String?
   
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case age
        case address = "homeAddress"
    }
}
```

CodingKeys의 각 열거형은 자신의 이름과 같은 rawValue를 갖게 됩니다. 그러나 address에는 "homeAddress"라는 이름의 rawValue를 따로 지정해주었습니다. 앞으로 homeAddress는 adress로 매핑됩니다.

> CodingKey란?
프로토콜의 한 종류이며 인코딩 및 디코딩을 하기 위한 키로 사용되는 타입입니다.

## Custom Encoding

인코딩의 커스텀이 필요할 때는 크게 두 가지가 있습니다. 첫째는 인코딩 시점의 값을 검증하거나 제약을 추가하는 경우이고 두번째는 인코딩 전략이나 Custom Key Mapping으로 원하는 결과를 얻을 수 없는 경우입니다. 직접 인코딩을 구현해야합니다.

```jsx
struct Employee: Codable {
   var name: String
   var age: Int
   var address: String?
}

let p = Employee(name: "James", age: 40, address: "Seoul")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

do {
   let jsonData = try encoder.encode(p)
   if let jsonStr = String(data: jsonData, encoding: .utf8) {
      print(jsonStr)
   }
} catch {
   print(error)
}
```

위 객체를 특정 조건에 맞게 인코딩 하기 위해서는 encode() 메서드를 다시 정의해야합니다. 이는 struct Employee 내부에 선언합니다. Codable 프로토콜은 Encodable, Decodable 프로토콜을 함께 가지고 있고, Encodable은 encode() 함수를 가지고 있습니다.

age의 범위가 30 이상, 60 이하일 때만 인코딩되도록 func encode(to encoder:)를 정의합니다.

```jsx
struct Employee: Codable {
   var name: String
   var age: Int
   var address: String?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self) // (1)
        try container.encode(name, forKey: .name) // (2)
        guard (30...60).contains(age) else { // (3)
            throw EncodingError.invalidRange
        }
        try container.encode(age, forKey: .age) // (4)
        try container.encodeIfPresent(address, forKey: .address) // (5)
    }
}
```

(1) 인코딩된 데이터는 인코더 내부에 컨테이너 형태로 저장됩니다. 이 컨테이너를 사용해야하기 때문에 컨테이너를 먼저 불러옵니다. 

(2) name 키에 name 속성값을 저장합니다.

(3) age가 범위 안에 있을 경우에만 인코딩이 가능하게 하도록 조건을 추가하기로 했습니다. guard문을 사용해 age가 범위를 벗어난다면 invalidRange error를 출력합니다. 범위에 맞다면 (4)번을 실행합니다.

(4) age 키에 age 속성값을 저장합니다.

(5) address 키에 adress 속성값을 저장합니다. 옵셔널 타입일 경우 encode()함수가 아닌 encodeIfPresent() 함수를 사용합니다. 

## Custom Decoding

인코딩에서 사용자화를 할 때에는 encode() 함수를 정의했습니다. 디코딩 사용자화에는 initializer를 정의합니다. 

```jsx
struct Employee: Codable {
   var name: String
   var age: Int
   var address: String?
   
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // (1)
        name = try container.decode(String.self, forKey: .name) // (2)
        age = try container.decode(Int.self, forKey: .age) // (3)
        guard (30...60).contains(age) else { // (4)
            throw DecodingError.invalidRange
        }
        address = try container.decodeIfPresent(String.self, forKey: .address) // (5)
    }
}
```

(1) 마찬가지로 container를 통해 접근해야하기 때문에 컨테이너를 불러옵니다.

(2) name 속성에 name 키 값을 저장합니다. 

(3) age 속성에 age 키 값을 저장합니다.

(4) 저장된 age의 범위가 30 이상 60 이하인지 확인하고 범위를 벗어날 경우 invalidRange를 출력합니다. 범위 내의 값이 맞다면 (5)번을 실행합니다.

(5) address 속성은 옵셔널 타입으로 decodeIfPresent() 함수를 사용해 디코딩합니다. 

커스텀인코딩과 커스텀디코딩의 큰 차이는 없습니다. 우선 컨테이너를 통해 접근해야한다는 점이 일치하고, encode 혹은 decode 함수를 사용하여 인코딩 및 디코딩을 진행합니다. 인코딩의 경우 조건이 있다면 그 조건에 맞도록 guard문을 사용해 값을 검증해보아야 하고 디코딩의 경우 조건이 있다면 guard문을 사용해 디코딩된 값을 검증해보아야 합니다. 속성이 옵셔널 타입인 경우 encodeIfPresent(), decodeIfPresent() 함수를 사용합니다.

encode() 함수의 파라미터로는 (어떤 속성값을, 어떤 키값으로 보내는지) 에 대한 두 개의 파라미터가 필요하고, 

decode() 함수의 파라미터로는 (어떤 타입의 자료로, 어떤 키값의 데이터를 가져오는지) 에 대한 두 개의 파라미터가 필요합니다.

# 6. URL Loading System

URL Loading System은 URL을 통해 네트워크의 서버와 통신하는 기술입니다. high-level API를 사용하고 있어 웬만한 작업은 모두 가능합니다. URL Loading System에서 가장 중요한 것은 URLSession입니다.

`URLSession`은 네트워크 연결을 설정하고 요청과 응답을 처리합니다. 네 종류의 URLSession이 있습니다.

1. Shared Session: 가장 단순합니다. Background 전송은 지원하지 않습니다.
2. Default Session: 세션을 직접 구성할 때 사용합니다. 델리게이터를 통해 세부적인 제어가 가능하고 서버에서 전달받은 응답은 디스크, 메모리 캐시에 저장합니다.
3. Ephemeral Session: 디폴트 세션과 비슷하지만 캐시와 쿠키 등을 디스크에 저장하지 않습니다.
4. Background Session: Background 전송 구현 시 사용합니다. 주로 private browsing을 구현할 때 사용합니다.

2, 3, 4번 Session은 Session Configration을 통해 객체를 생성한 뒤 사용해야합니다.

`Task`는 URLSession을 통해 전달하는 개별 요청을 뜻합니다. 

1. data task: API서버와의 통신에 적합합니다. URLSession에서는 대개 data task를 사용합니다.
2. upload task, download task: 파일 전송 구현시 사용합니다. background 전송을 지원합니다.
3. stream task: 채팅과 같은 TCP 프로그램을 구현시 적합합니다.

URLSession를 통해 task를 만드는 데까지는 어려움이 없습니다. 많이 하는 실수는 task를 불러오지 않아 일어나는 실수입니다. 반드시 task를 생성하고 `resume()`을 사용해 직접 호출해야합니다.

# 7. Data Task