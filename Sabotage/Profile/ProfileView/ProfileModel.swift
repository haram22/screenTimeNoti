//
//  ProfileModel.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/01.
//

import Foundation

struct Model{
    var subtitle : String
    var title: String
}

extension Model{
    static var medeling = [
            [
                Model(subtitle: "내 정보", title: "알림 설정"),
            ],
            [
                Model(subtitle: "이용 안내", title: "개인정보 처리방침"),
                Model(subtitle: "이용 안내", title: "서비스 이용약관"),
                Model(subtitle: "이용 안내", title: "고객센터"),
            ]
    ]
}

