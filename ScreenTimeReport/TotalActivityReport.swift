//
//  TotalActivityReport.swift
//  ScreenTimeReport
//
//  Created by 김하람 on 12/28/23.
//
import DeviceActivity
import SwiftUI
import UserNotifications


// MARK: - 각각의 Device Activity Report들에 대응하는 컨텍스트 정의
extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    /// 해당 리포트의 내용 렌더링에 사용할 DeviceActivityReportScene에 대응하는 익스텐션이 필요합니다.  ex) TotalActivityReport
    static let totalActivity = Self("Total Activity")
}
// MARK: - ram : dictionary for triger check
var notificationSentForApps: [String: Bool] = [:]

class ActivityTimesManager {
    var appActivityTimes: [String: (startTime: Date?, endTime: Date?)] = [:]

    func updateEndTime(for appName: String, with endTime: Date) {
        if let _ = appActivityTimes[appName] {
            appActivityTimes[appName]?.endTime = endTime
        }
    }
}
let activityTimesManager = ActivityTimesManager()


// MARK: - Device Activity Report의 내용을 어떻게 구성할 지 설정
struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    /// 보여줄 리포트에 대한 컨텍스트를 정의해줍니다.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    /// 어떤 데이터를 사용해서 어떤 뷰를 보여줄 지 정의해줍니다. (SwiftUI View)
    let content: (ActivityReport) -> TotalActivityView
    var activityStartTime: Date?
    
    // MARK: - ram : 시작시간 끝시간 저장하는 딕셔너리
    var appActivityTimes: [String: (startTime: Date?, endTime: Date?)] = [:]
    
    
    /// DeviceActivityResults 데이터를 받아서 필터링
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        var totalActivityDuration: Double = 0
        var list: [AppDeviceActivity] = []
        let limitTime: Double = 2700
        let specificLimitTime: Double = 180
        
        for await eachData in data {
                for await activitySegment in eachData.activitySegments {
                    for await categoryActivity in activitySegment.categories {
                        for await applicationActivity in categoryActivity.applications {
                            let appName = (applicationActivity.application.localizedDisplayName ?? "nil") /// 앱 이름
                            let bundle = (applicationActivity.application.bundleIdentifier ?? "nil")
                            let duration = applicationActivity.totalActivityDuration

                            // 활동 시작 시간 기록
                            if activityTimesManager.appActivityTimes[appName]?.startTime == nil {
                                activityTimesManager.appActivityTimes[appName] = (startTime: Date(), endTime: nil)
                            }

                            // 활동 종료 시간 기록 및 시간 차이 계산
//                            if duration >= specificLimitTime {
//                                activityTimesManager.appActivityTimes[appName]?.endTime = Date()
//                                if let startTime = activityTimesManager.appActivityTimes[appName]?.startTime,
//                                   let endTime = activityTimesManager.appActivityTimes[appName]?.endTime {
//                                    let timeSpent = endTime.timeIntervalSince(startTime)
//                                    if timeSpent > specificLimitTime {
//                                        // 시간 초과 처리
//                                        scheduleNotification_each02(appName: applicationActivity.application.localizedDisplayName!)
//                                    } else if timeSpent < specificLimitTime {
//                                        // 시간 미달 처리
//                                        activityTimesManager.appActivityTimes[appName]?.startTime = Date()
//                                        scheduleNotification_each00(appName: applicationActivity.application.localizedDisplayName!)
//                                    } else {
//                                        // 시간 정확히 맞음 처리
//                                        scheduleNotification_each01(appName: applicationActivity.application.localizedDisplayName!)
//                                    }
//                                }
//                            }
                            activityTimesManager.appActivityTimes[appName]?.endTime = Date()
                            if let startTime = activityTimesManager.appActivityTimes[appName]?.startTime,
                               let endTime = activityTimesManager.appActivityTimes[appName]?.endTime {
                                let timeSpent = endTime.timeIntervalSince(startTime)
                                if timeSpent > specificLimitTime {
                                    // 시간 초과 처리
                                    scheduleNotification_each02(appName: applicationActivity.application.localizedDisplayName!)
                                }
                                if timeSpent < specificLimitTime {
                                    // 시간 미달 처리
                                    scheduleNotification_each00(appName: applicationActivity.application.localizedDisplayName!)
                                }
                                if timeSpent == specificLimitTime {
                                    // 시간 정확히 맞음 처리
                                    scheduleNotification_each01(appName: applicationActivity.application.localizedDisplayName!)
                                }
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
//                if totalActivityDuration >= limitTime - 60 && totalActivityDuration <= limitTime  { // 10 minutes
//                    scheduleNotification0()
//                }
//                if totalActivityDuration >= limitTime && totalActivityDuration <= limitTime + 60 { // 10 minutes
//                    scheduleNotification1()
//                }
//                else if totalActivityDuration >= limitTime + 60 && totalActivityDuration <= limitTime + 120 { // 10 minutes
//                    scheduleNotification2()
//                }
                    func scheduleNotification_each00(appName: String) {
                        if notificationSentForApps["\(appName)01"] != true {
                            let content = UNMutableNotificationContent()
                            content.title = "⚠️ 1분 되기 전 ⚠️"
                            content.body = "You have used \(appName) for 10 minutes."
                            content.sound = .default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)01"] = true
                        }
                    }
                    func scheduleNotification_each01(appName: String) {
                        if notificationSentForApps["\(appName)02"] != true {
                            let content = UNMutableNotificationContent()
                            content.title = "🔥 1분 썼음 🔥"
                            content.body = "You have used \(appName) for 10 minutes."
                            content.sound = .default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)02"] = true
                        }
                    }
                    func scheduleNotification_each02(appName: String) {
                        if notificationSentForApps["\(appName)03"] != true {
                            let content = UNMutableNotificationContent()
                            content.title = "😱 1분 넘었음 😱"
                            content.body = "You have used \(appName) for 10 minutes."
                            content.sound = .default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)03"] = true
                        }
                    }
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
                
            }
        }
        
        /// 필터링된 ActivityReport 데이터들을 반환
        return ActivityReport(totalDuration: totalActivityDuration, apps: list)
    }
}


//import DeviceActivity
//import SwiftUI
//
//extension DeviceActivityReport.Context {
//    // If your app initializes a DeviceActivityReport with this context, then the system will use
//    // your extension's corresponding DeviceActivityReportScene to render the contents of the
//    // report.
//    static let totalActivity = Self("Total Activity")
//}
//
//struct TotalActivityReport: DeviceActivityReportScene {
//    // Define which context your scene will represent.
//    let context: DeviceActivityReport.Context = .totalActivity
//    
//    // Define the custom configuration and the resulting view for this report.
//    let content: (String) -> TotalActivityView
//    
//    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> String {
//        // Reformat the data into a configuration that can be used to create
//        // the report's view.
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.day, .hour, .minute, .second]
//        formatter.unitsStyle = .abbreviated
//        formatter.zeroFormattingBehavior = .dropAll
//        
//        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
//            $0 + $1.totalActivityDuration
//        })
//        return formatter.string(from: totalActivityDuration) ?? "No activity data"
//    }
//}
