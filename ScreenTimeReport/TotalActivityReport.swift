//
//  TotalActivityReport.swift
//  ScreenTimeReport
//
//  Created by 김하람 on 12/28/23.
//
import DeviceActivity
import SwiftUI
import UserNotifications

extension DeviceActivityReport.Context {
    static let totalActivity = Self("Total Activity")
}
// MARK: - ram : dictionary for triger check
var notificationSentForApps: [String: Bool] = [:]

struct TotalActivityReport: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .totalActivity
    let content: (ActivityReport) -> TotalActivityView
    var activityStartTime: Date?
    func makeConfiguration(
        representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        var totalActivityDuration: Double = 0 /// 총 스크린 타임 시간
        var list: [AppDeviceActivity] = [] /// 사용 앱 리스트
            let limitTime: Double = 2700
            let specificLimitTime: Double = $selectedGoalHours //38
            
        for await eachData in data {
            for await activitySegment in eachData.activitySegments {
                for await categoryActivity in activitySegment.categories {
                    /// 이 카테고리의 totalActivityDuration에 기여한 사용자의 application Activity
                    for await applicationActivity in categoryActivity.applications {
                        let appName = (applicationActivity.application.localizedDisplayName ?? "nil") /// 앱 이름
                        let bundle = (applicationActivity.application.bundleIdentifier ?? "nil") /// 앱 번들id
                        let duration = applicationActivity.totalActivityDuration /// 앱의 total activity 기간
                        // MARK: - ram: 각 앱에 대한 시간처리 조건문
                        if duration >= specificLimitTime - 60 && duration <= specificLimitTime  { // 10 minutes
                            scheduleNotification_each0(appName: applicationActivity.application.localizedDisplayName!)
                        }
                        if duration >= specificLimitTime && duration <= specificLimitTime + 60  { // 10 minutes
                            scheduleNotification_each1(appName: applicationActivity.application.localizedDisplayName!)
//                            setNotifications()
                            
                        }
                        if duration >= specificLimitTime + 60 && duration <= specificLimitTime + 120  { // 10 minutes
                            scheduleNotification_each2(appName: applicationActivity.application.localizedDisplayName!)
                        }
                        totalActivityDuration += duration
                        let numberOfPickups = applicationActivity.numberOfPickups /// 앱에 대해 직접적인 pickup 횟수
                        let token = applicationActivity.application.token /// 앱의 토큰
                        let appActivity = AppDeviceActivity(
                            id: bundle,
                            displayName: appName,
                            duration: duration,
                            numberOfPickups: numberOfPickups,
                            token: token
                        )
                        list.append(appActivity)
                    }
                }
                // MARK: - ram : 전체 시간에 대한 처리
                if totalActivityDuration >= limitTime - 60 && totalActivityDuration <= limitTime  { // 10 minutes
                    scheduleNotification0()
                }
                if totalActivityDuration >= limitTime && totalActivityDuration <= limitTime + 60 { // 10 minutes
                    scheduleNotification1()
                }
                else if totalActivityDuration >= limitTime + 60 && totalActivityDuration <= limitTime + 120 { // 10 minutes
                    scheduleNotification2()
                }
//                func setNotifications() {
//                    let manager = LocalNotificationManager()
////                    manager.requestPermission()
//                    manager.requestPermission()
//                    manager.addNotification(title: "This is a test reminder")
//                    manager.schedule()
//                }
                func scheduleNotification_each0(appName: String) {
                    if notificationSentForApps["\(appName)1"] != true {
                        let content = UNMutableNotificationContent()
                        content.title = "✅ 1분 전임"
                        content.body = "You have used \(appName) for 10 minutes."
                        content.sound = .default

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)1"] = true
                        }
                }
                func scheduleNotification_each1(appName: String) {
                    if notificationSentForApps["\(appName)2"] != true {
                        let content = UNMutableNotificationContent()
                        content.title = "🔥 끝"
                        content.body = "You have used \(appName) for 10 minutes."
                        content.sound = .default

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)2"] = true
                        }
                    
                }
                func scheduleNotification_each2(appName: String) {
                    if notificationSentForApps["\(appName)3"] != true {
                        let content = UNMutableNotificationContent()
                        content.title = "🚨🚨🚨 초과 🚨🚨🚨"
                        content.body = "You have used \(appName) for 10 minutes."
                        content.sound = .default

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)3"] = true
                        }
                    
                }
                // MARK: - ram : 전체 시간에 대한 처리
                func scheduleNotification0() {
                    let content = UNMutableNotificationContent()
                    content.title = "⚠️ limit Time 10분 전임 "
                    content.body = "You have used the app for 10 minutes."
                    content.sound = .default

                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    UNUserNotificationCenter.current().add(request)
                }
                func scheduleNotification1() {
                    let content = UNMutableNotificationContent()
                    content.title = "🙌🏻 limit Time임 "
                    content.body = "You have used the app for 10 minutes."
                    content.sound = .default

                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    UNUserNotificationCenter.current().add(request)
                }
                func scheduleNotification2() {
                    let content = UNMutableNotificationContent()
                    content.title = "🚨 10분 지났음 이제 꺼"
                    content.body = "You have used the app for 10 minutes."
                    content.sound = .default

                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    UNUserNotificationCenter.current().add(request)
                }
            }
        }
        
        /// 필터링된 ActivityReport 데이터들을 반환
        return ActivityReport(totalDuration: totalActivityDuration, apps: list)
    }
}

