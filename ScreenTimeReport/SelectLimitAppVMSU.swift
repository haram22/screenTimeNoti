//
//  SelectLimitAppVMSU.swift
//  Sabotage
//
//  Created by 김하람 on 12/28/23.
//

import Foundation
import SwiftUI
import FamilyControls

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var settingIndex = 0
    @State var selection = FamilyActivitySelection()
    @State private var isPresented = false
    
    private let columns = [
        GridItem(.fixed(56)),
        GridItem(.fixed(56)),
        GridItem(.fixed(56)),
        GridItem(.fixed(56)),
        GridItem(.fixed(56))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            SelectAppContainerView()
            Spacer()
        }
        .background(Color.white, ignoresSafeAreaEdges: .all)
        .onAppear() {
            selection = ScreenTimeVM.shared.selectionToDiscourage
        }
    }
}

extension DetailView {
    
    private func SelectAppContainerView() -> some View {
        // TODO::Pick interface
        // VERSION 1
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("제한 중인 앱 목록")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Button("편집") { isPresented = true }
                    .familyActivityPicker(
                        isPresented: $isPresented,
                        selection: $selection)
                    .font(.subheadline)
                    .padding(.horizontal, 10.0)
                    .padding(.vertical, 4.0)
                    .background(.white)
                    .border(.white, width: 0)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 0.40)
            // 앱 아이콘 나오는 부분
            SelectedAppListView()
        }
    }
    func SelectedAppListView() -> some View {
        VStack {
            if (selection.applicationTokens.count > 0 || selection.categoryTokens.count > 0) {
                LazyVGrid(columns: columns, alignment: .leading){
                    if selection.applicationTokens.count > 0 {
                        ForEach(Array(selection.applicationTokens), id: \.self) {
                            token in
                            HStack {
                                Label(token)
                                    .labelStyle(.iconOnly)
                                    .scaleEffect(2.5)
                            }
                            .frame(width: 56, height: 56)
                        }
                    }
                    if selection.categoryTokens.count > 0 {
                        ForEach(Array(selection.categoryTokens), id: \.self) {
                            token in
                            HStack {
                                Label(token)
                                    .labelStyle(.iconOnly)
                                    .scaleEffect(1.8)
                            }
                            .frame(width: 56, height: 56)
                        }
                    }
                }
                .padding(0.6)
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(Color.blue)
                .cornerRadius(16)
            } else {
                Text("선택된 앱이 없습니다.")
                    .foregroundColor(.clear)
                    .padding(0.6)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.indigo)
                    .cornerRadius(16)
            }
        }
        .padding(.top, 0.50)
        .padding(.horizontal, 0.50)
    }
}

extension DetailView {
    private func handleSavePlan() {
        ScreenTimeVM.shared.selectionToDiscourage = selection
        
        dismiss()
    }
}
