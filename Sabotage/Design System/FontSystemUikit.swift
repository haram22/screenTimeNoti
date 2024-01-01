//
//  FontSystemSU.swift
//  Sabotage
//
//  Created by 오성진 on 1/1/24.
//

import UIKit

extension UIFont {
    static func LargeTitle(size fontSize: CGFloat = 34.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Title1(size fontSize: CGFloat = 28.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Title2(size fontSize: CGFloat = 22.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Title3(size fontSize: CGFloat = 20.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Headline(size fontSize: CGFloat = 17.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Body(size fontSize: CGFloat = 17.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Callout(size fontSize: CGFloat = 16.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Subhead(size fontSize: CGFloat = 15.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Footnote(size fontSize: CGFloat = 13.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Caption1(size fontSize: CGFloat = 12.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    static func Caption2(size fontSize: CGFloat = 11.0) -> UIFont {
        let familyName = "Apple SD Gothic Neo"
        let weightString = "Regular"
        return UIFont (name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
