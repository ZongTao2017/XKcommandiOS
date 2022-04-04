//
//  FileManager.swift
//  XKcommand
//
//  Created by Tao Zong on 3/7/22.
//

import Foundation

let fileName: String = "paired"

func saveToFile(_ pairedDevices: [DeviceInfo]) {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: pairedDevices, requiringSecureCoding: false)
        try data.write(to: path)
        print("save file done")
    } catch {
        print("save file error !!!")
    }
}

func loadFromFile() -> [DeviceInfo] {
    var devices: [DeviceInfo] = [DeviceInfo]()
    do {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        let fileData = try Data(contentsOf: fileURL)
        let unarchiver = try NSKeyedUnarchiver(forReadingFrom: fileData)
        unarchiver.requiresSecureCoding = false
        let obj = unarchiver.decodeObject(of: [DeviceInfo.self], forKey: NSKeyedArchiveRootObjectKey)
        if let error = unarchiver.error {
            print("Error:\(error)")
        }
        devices = obj as! [DeviceInfo]
        return devices
    } catch {
        print("load file error !!!")
    }
    return devices
}
