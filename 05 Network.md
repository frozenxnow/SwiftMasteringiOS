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