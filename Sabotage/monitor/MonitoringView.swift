//
//  MonitoringView.swift
//  Sabotage
//
//  Created by 김하람 on 12/31/23.
//

import DeviceActivity
import SwiftUI

// MARK: - Device Activity Report 내용을 보여주는 뷰
struct MonitoringView: View {
    @EnvironmentObject var scheduleVM: ScheduleVM
    
    @State private var context: DeviceActivityReport.Context = .totalActivity
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day,
                for: .now
            ) ?? DateInterval()
        )
    )
    
    var body: some View {
        DeviceActivityReport(context, filter: filter)
            .onAppear {
                filter = DeviceActivityFilter(
                    segment: .daily(
                        during: Calendar.current.dateInterval(
                            of: .day, for: .now
                        ) ?? DateInterval()
                    ),
                    users: .all,
                    devices: .init([.iPhone]),
                    // MARK: - ram 우리가 제한한 앱만 보여줌
                    applications: scheduleVM.selection.applicationTokens,
                    categories: scheduleVM.selection.categoryTokens
                )
            }
        
    }
}

struct MonitoringView_Previews: PreviewProvider {
    static var previews: some View {
        MonitoringView()
    }
}
