//
//  ScreenTimeVMSU.swift
//  Sabotage
//
//  Created by 김하람 on 12/29/23.
//

import DeviceActivity
import FamilyControls
import Foundation
import ManagedSettings
import SwiftUI

class ScreenTimeVM: ObservableObject {
    static let shared = ScreenTimeVM()
    
    private init() {}
    
    // MARK: 제한할 앱 정보를 담고 있는 변수
    @AppStorage(AppStorageKey.selectionToDiscourage.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var selectionToDiscourage = FamilyActivitySelection()
}
