//
//  ActionApi.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import Foundation
import SwiftUI

func actionPostRequest(with category: String, content: String) {
    // 서버 링크가 유요한지 확인
    guard let url = URL(string: "\(urlLink)actionItem") else {
        print("🚨 Invalid URL")
        return
    }
    print("✅ Valid URL = \(url)")
    // request 생성하기
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // json 형식으로 데이터 전송할 것임
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // POST로 요청할 경우 : json 형식으로 데이터 넘기기
    let body:[String: AnyHashable] = [
        "category": category,
        "content": content
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    // data task 생성하기
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        // 응답 처리하기
        if let error = error {
            print("🚨 Error: \(error.localizedDescription)")
            return
        }
        
        // 데이터가 비어있는지 확인
        guard let data = data, !data.isEmpty else {
            print("✅ [actionPostRequest] No data returned from the server")
            return
        }
        do {
            // 데이터를 성공적으로 받은 경우, 해당 데이터를 JSON으로 파싱하기
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            // 정상적으로 response를 받은 경우, notification center를 사용하여 알림 보내기
            print("✅ success: \(response)")
            DispatchQueue.main.async {
                //                NotificationCenter.default.post(name: .addNotification, object: nil)
                print("✅ notification 완료 in limitPostRequest")
            }
        } catch {
            print("🚨 ", error)
        }
    }
    // 시작하기. 꼭 적어줘야 함 !
    task.resume()
}

func actionPatchRequest(with category: String, content: String) {
    guard let url = URL(string: "\(urlLink)actionItem/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = [
        "category": category,
        "content": content
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("✅ success: \(response)")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    //                    NotificationCenter.default.post(name: .addNotification, object: nil)
                }
            }
        } catch {
            print("🚨 ", error)
        }
    }
    task.resume()
}

// MARK: - 아직 구현 중
func showActionPatchRequest(with category: String, content: String) {
    guard let url = URL(string: "\(urlLink)actionItem/expose/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = [
        "category": category,
        "content": content
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("✅ success: \(response)")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    //                    NotificationCenter.default.post(name: .addNotification, object: nil)
                }
            }
        } catch {
            print("🚨 ", error)
        }
    }
    task.resume()
}

//func getActionData() {
//    if let url = URL(string: "\(urlLink)actionItem/\(userId)/all") {
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { data, response, error in
//                   if let error = error {
//                       print("🚨 Error: \(error.localizedDescription)")
//                       return
//                   }
//            // JSON data를 가져온다. optional 풀어줘야 함
//            if let JSONdata = data {
//                let dataString = String(data: JSONdata, encoding: .utf8) //얘도 확인을 위한 코드임
//                print(dataString!)
//                // JSONDecoder 사용하기
//                let decoder = JSONDecoder() // initialize
//                do {
//                                    let decodeData = try decoder.decode(ActionItemData.self, from: JSONdata)
//                                    DispatchQueue.main.async {
//                                        self.ActionItemData = decodeData
//                                        // self.collectionView.reloadData()
//                                    }
//                                } catch {
//                                    print("🚨 JSON decoding error: \(error)")
//                                }
//            }
//        }
//        task.resume()
//    }
//}
