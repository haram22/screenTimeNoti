//
//  ScheduleView.swift
//  Sabotage
//
//  Created by 김하람 on 12/31/23.
//

import SwiftUI
import FamilyControls
/**
 
 1. 권한 설정 확인할 수 있어야함
 2. 스케쥴 설정(시간 설정)
 3. 앱 설정
 4. 설정한 스케쥴 및 앱 설정을 바탕으로 모니터링 스케쥴 만들기
 
 */

struct ScheduleView: View {
//    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var scheduleVM: ScheduleVM

    /// 스케쥴 저장 버튼을 누르기 전 선택한 앱들을 저장하고 있을 변수입니다.
    @State var tempSelection = FamilyActivitySelection()
    
    var body: some View {
        NavigationView {
            VStack {
                setupListView()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar { savePlanButtonView() }
            .navigationTitle("Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .familyActivityPicker(
                isPresented: $scheduleVM.isFamilyActivitySectionActive,
                selection: $tempSelection
            )
            .alert("저장 되었습니다.", isPresented: $scheduleVM.isSaveAlertActive) {
                Button("OK", role: .cancel) {}
            }
        }
        .onAppear {
            tempSelection = scheduleVM.selection
        }
    }
}

// MARK: - Views
extension ScheduleView {
    
    /// 스케쥴 페이지 우측 툴바 상단 버튼입니다.
    private func savePlanButtonView() -> ToolbarItemGroup<Button<Text>> {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            let BUTTON_LABEL = "스케쥴 저장"
            
            Button {
                scheduleVM.saveSchedule(selectedApps: tempSelection)
            } label: {
                Text(BUTTON_LABEL)
            }
        }
    }
    
    /// 스케쥴 페이지 내 전체 리스트 뷰입니다.
    private func setupListView() -> some View {
        List {
            setUpTimeSectionView()
            setUPAppSectionView()
        }
        .listStyle(.insetGrouped)
    }
    
    /// 전체 리스트 중 시간 설정 섹션에 해당하는 뷰입니다.
    private func setUpTimeSectionView() -> some View {
        let TIME_LABEL_LIST = ["시작 시간", "종료 시간"]
        let times = [$scheduleVM.scheduleStartTime, $scheduleVM.scheduleEndTime]
        
        return Section(
            header: Text(ScheduleSectionInfo.time.header),
            footer: Text(ScheduleSectionInfo.time.footer)) {
                ForEach(0..<TIME_LABEL_LIST.count, id: \.self) { index in
                    DatePicker(selection: times[index], displayedComponents: .hourAndMinute) {
                        Text(TIME_LABEL_LIST[index])
                    }
                }
            }
    }
    
    /// 전체 리스트 중 앱 설정 섹션에 해당하는 뷰입니다.
    private func setUPAppSectionView() -> some View {
        let BUTTON_LABEL = "변경"
        let EMPTY_TEXT = "Choose Your App"
        
        return Section(
            header: HStack {
                Text(ScheduleSectionInfo.apps.header)
                Spacer()
                Button {
                    scheduleVM.showFamilyActivitySelection()
                } label: {
                    Text(BUTTON_LABEL)
                }
            },
            footer: Text(ScheduleSectionInfo.apps.footer)
        ) {
            if isSelectionEmpty() {
                Text(EMPTY_TEXT)
                    .foregroundColor(Color.secondary)
            } else {
                ForEach(Array(tempSelection.applicationTokens), id: \.self) { token in
                    Label(token)
                }
                ForEach(Array(tempSelection.categoryTokens), id: \.self) { token in
                    Label(token)
                }
                ForEach(Array(tempSelection.webDomainTokens), id: \.self) { token in
                    Label(token)
                }
            }
        }
    }
    
    
    
}

// MARK: - Methods
extension ScheduleView {
    
    /// 사용자가 선택한 앱 & 도메인 토큰이 비어있는지 확인하기 위한 메서드입니다.
    private func isSelectionEmpty() -> Bool {
        tempSelection.applicationTokens.isEmpty &&
        tempSelection.categoryTokens.isEmpty &&
        tempSelection.webDomainTokens.isEmpty
    }
    
}
