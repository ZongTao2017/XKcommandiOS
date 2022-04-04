//
//  CommonTypes.swift
//  XKcommand
//
//  Created by Tao Zong on 2/19/22.
//

import Foundation
import SwiftUI

public extension Data {
  func hexString(separator: String = " ") -> String {
    return self.map { String(format: "%02hhx", $0) }.joined(separator: separator)
  }
}

let deviceNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkDeviceStatus"))
let deviceNameNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkDeviceName"))
let rssiNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkDeviceRSSI"))
let currentRssiNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkCurrentRSSI"))
let donePairNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkDonePair"))
let powerNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkPowerStatus"))
let sysNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkSystemInfo"))
let button1Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton1Status"))
let button2Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton2Status"))
let button3Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton3Status"))
let button4Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton4Status"))
let button5Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton5Status"))
let button6Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton6Status"))
let button7Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton7Status"))
let button8Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton8Status"))
let enableNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkHideDeviceList"))
let disableNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkShowDeviceList"))
let warnNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkPopupWarning"))
let cameraNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkCameraDone"))
let updateButtonNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkUpdateButton"))

public extension Notification.Name {
    static let xkDeviceStatus = Notification.Name("xkDeviceStatus")
    static let xkDeviceName = Notification.Name("xkDeviceName")
    static let xkDeviceRSSI = Notification.Name("xkDeviceRSSI")
    static let xkCurrentRSSI = Notification.Name("xkCurrentRSSI")
    static let xkDonePair = Notification.Name("xkDonePair")
    static let xkPowerStatus = Notification.Name("xkPowerStatus")
    static let xkSystemInfo = Notification.Name("xkSystemInfo")
    static let xkButton1Status = Notification.Name("xkButton1Status")
    static let xkButton2Status = Notification.Name("xkButton2Status")
    static let xkButton3Status = Notification.Name("xkButton3Status")
    static let xkButton4Status = Notification.Name("xkButton4Status")
    static let xkButton5Status = Notification.Name("xkButton5Status")
    static let xkButton6Status = Notification.Name("xkButton6Status")
    static let xkButton7Status = Notification.Name("xkButton7Status")
    static let xkButton8Status = Notification.Name("xkButton8Status")
    static let xkShowDeviceList = Notification.Name("xkShowDeviceList")
    static let xkHideDeviceList = Notification.Name("xkHideDeviceList")
    static let xkPopupWarning = Notification.Name("xkPopupWarning")
    static let xkCameraDone = Notification.Name("xkCameraDone")
    static let xkUpdateButton = Notification.Name("xkUpdateButton")
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
