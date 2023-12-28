//
//  Bundle_Extension.swift
//  Sabotage
//
//  Created by 김하람 on 12/28/23.
//

import Foundation

extension Bundle {

    var appGroupName: String {
        /// plist 파일에서 key값에 해당하는 값을 String으로 불러옵니다.
        guard let value = Bundle.main.infoDictionary?["APP_GROUP_NAME"] as? String else {
            fatalError("APP_NAME not set in Info.plist")
        }
        return value
    }
}
