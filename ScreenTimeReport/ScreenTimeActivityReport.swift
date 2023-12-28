//
//  ScreenTimeActivityReport.swift
//  ScreenTimeReport
//
//  Created by 김하람 on 12/28/23.
//

import Foundation
import ManagedSettings

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var duration: TimeInterval
    var numberOfPickups: Int
    var token: ApplicationToken?
}

extension TimeInterval {
    /// TimeInterval 타입 값을 00:00 형식의 String으로 변환해주는 메서드
    func toString() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d", hours,minutes)
    }
}
