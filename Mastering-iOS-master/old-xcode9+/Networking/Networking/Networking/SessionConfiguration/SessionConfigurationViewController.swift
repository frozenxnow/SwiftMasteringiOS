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

class SessionConfigurationViewController: UIViewController {
   
   @IBAction func useSharedConfiguration(_ sender: Any) {
      // Code Input Point #1
    sendRequest(using: URLSession.shared)
      // Code Input Point #1
   }
   
   @IBAction func useDefaultConfiguration(_ sender: Any) {
      // Code Input Point #2
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    sendRequest(using: session)
    // Code Input Point #2
   }
   
   @IBAction func useEphemeralConfiguration(_ sender: Any) {
      // Code Input Point #3
    let configuration = URLSessionConfiguration.ephemeral
    let session = URLSession(configuration: configuration)
    sendRequest(using: session)
      // Code Input Point #3
   }
   
   @IBAction func useBackgroundConfiguration(_ sender: Any) {
      // Code Input Point #4
    let configuration = URLSessionConfiguration.background(withIdentifier: "DownTask")
    let session = URLSession(configuration: configuration)
    sendRequest(using: session)
      // Code Input Point #4
    // crash: 컴플리션 핸들러를 지원하지 않는다. 혹은 delegate를 함께 구현해야한다.
   }
   
   @IBAction func useCustomConfiguration(_ sender: Any) {
      // Code Input Point #5
      // 기본 제공되는 configuration을 수정하는 방식으로 사용
    let configuration = URLSessionConfiguration.default
    
    configuration.timeoutIntervalForRequest = 30 // 30초동안 응답 없을경우 요청 취소, 오류 전달
    configuration.httpAdditionalHeaders = ["ZUMO-API-VERSION" : "2.0.0"] // 모든 요청에 공통적으로 추가할 헤더 설정
    configuration.networkServiceType = .responsiveData
    // urlsession이 처리하는 작업의 종류 지정, 여기에 지정된 것을 기반으로 네트워크 처리 방식을 최적화한다
    
    let session = URLSession(configuration: configuration)
    sendRequest(using: session)
      // Code Input Point #5
   }
   
   func sendRequest(using session: URLSession) {
      guard let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string") else {
         fatalError("Invalid URL")
      }
      
      let task = session.dataTask(with: url) { (data, response, error) in
         if let error = error {
            self.showErrorAlert(with: error.localizedDescription)
            print(error)
            return
         }
         
         guard let httpResponse = response as? HTTPURLResponse else {
            self.showErrorAlert(with: "Invalid Response")
            return
         }
         
         guard (200...299).contains(httpResponse.statusCode) else {
            self.showErrorAlert(with: "\(httpResponse.statusCode)")
            return
         }
         
         guard let data = data, let str = String(data: data, encoding: .utf8) else {
            fatalError("Invalid Data")
         }
         
         self.showInfoAlert(with: str)
      }
      
      task.resume()
   }
}
