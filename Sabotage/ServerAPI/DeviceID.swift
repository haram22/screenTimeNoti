//
//  DeviceID.swift
//  Sabotage
//
//  Created by 김하람 on 1/1/24.
//
import UIKit
import TAKUUID
import Foundation
import SwiftUI

func deviceIDPostRequest(with deviceId: String) {
    // 서버 링크가 유요한지 확인
    guard let url = URL(string: "\(urlLink)user") else {
        print("🚨 Invalid URL")
        return
    }
    print("✅ Valid URL = \(url)")
    
    // request 생성하기
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // POST로 요청할 경우 : json 형식으로 데이터 넘기기
    let body: [String: AnyHashable] = [
        "deviceId": deviceId
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    // data task 생성하기
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        // 오류 처리
        if let error = error {
            print("🚨 Error: \(error.localizedDescription)")
            return
        }
        
        // 데이터가 비어있는지 확인
        guard let data = data, !data.isEmpty else {
            print("✅ [deviceIDPostRequest] No data returned from the server")
            return
        }
        
        do {
            // 데이터를 성공적으로 받은 경우, 해당 데이터를 JSON으로 파싱하기
            //            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // 'data' 필드를 찾아서 딕셔너리로 캐스팅
                if let data = response["data"] as? [String: Any] {
                    // 'data' 딕셔너리에서 'id' 값을 추출
                    if let id = data["id"] as? Int {
                        UserDefaults.standard.set(id, forKey: "userID")
                        print("ID: \(id)")
                        print("USERID: \(UserDefaults.standard.string(forKey: "userID"))")
                    }
                }
                print("✅ \(response)")
            }
            
        } catch {
            print("🚨 JSON parsing error: ", error)
        }
    }
    
    // 작업 시작
    task.resume()
}

func initUUID() {
    let uuidStorage = TAKUUIDStorage.sharedInstance()
    uuidStorage.migrate()
    if let uuid = uuidStorage.findOrCreate() {
        print("🔑 = \(uuid)")
        deviceIDPostRequest(with: uuid)
    } else {
        print("🔑 = nil")
    }
    
}

