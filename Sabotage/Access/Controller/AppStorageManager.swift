//
//  AppStorageManager.swift
//  Sabotage
//
//  Created by 김하람 on 12/29/23.
//

import Foundation

public enum AppStorageKey: String {
    case selectionToDiscourage // FamilyActivitySelection
    case sleepStartDateComponent
    case sleepEndDateComponent
    case daysOfWeek
    case isUserNotificationOn
    case additionalCount
    case isEndPoint
    case isUserInit
    case hasNotificationPermission
    case hasScreenTimePermission
    case testCount
    case additionalMinute // 핸드폰 추가 사용 시간
    case warningTime // 미리 알림 시간
}

// MARK: 실기 테스트 시 App Groups 설정 후 동일한 이름으로 수정하세요.
let APP_GROUP_NAME = "group.com.mustsleep"
