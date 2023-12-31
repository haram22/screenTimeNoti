//
//  noti.swift
//  Sabotage
//
//  Created by 김하람 on 12/31/23.
//

import SwiftUI

struct NotiView: View {
    // 로컬 알림 설정 함수
    func setNotifications() {
        let manager = LocalNotificationManager()
        manager.requestPermission()
        manager.addNotification(title: "This is a test reminder")
        manager.schedule()
    }
    
    // 뷰의 바디
    var body: some View {
        VStack {
            Text("Notification Demo")
//            Button(action: { self.setNotification() }) {
//                Text("Set Notification!")
//            }
        }
    }
}

// 프리뷰 제공자
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
