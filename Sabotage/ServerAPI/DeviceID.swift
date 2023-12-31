//
//  DeviceID.swift
//  Sabotage
//
//  Created by 김하람 on 1/1/24.
//
import UIKit
import TAKUUID

private func initUUID() {
    let uuidStorage = TAKUUIDStorage.sharedInstance()
    uuidStorage.migrate()
    uuidInTheKeyChain.text = uuidStorage.findOrCreate()
//        uuidInTheKeyChain.text = "fsfdfd"
}
