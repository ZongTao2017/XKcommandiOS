//
//  PowerButtonView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/13/22.
//

import SwiftUI

struct PowerButtonView: View {
    @State var button1: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[0]
    @State var button2: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[1]
    @State var button3: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[2]
    @State var button4: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[3]
    @State var button5: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[4]
    @State var button6: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[5]
    @State var button7: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[6]
    @State var button8: ButtonInfo = DeviceManager.default.getActiveDevice().buttons[7]
    @State var clickable: Bool = false
    
    let button1Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton1Status"))
    let button2Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton2Status"))
    let button3Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton3Status"))
    let button4Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton4Status"))
    let button5Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton5Status"))
    let button6Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton6Status"))
    let button7Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton7Status"))
    let button8Notif = NotificationCenter.default.publisher(for: NSNotification.Name("xkButton8Status"))
    let powerNotif = NotificationCenter.default.publisher(for: NSNotification.Name("xkPowerStatus"))
    
    var body: some View {
        ZStack {
            if clickable {
                Image("Power_base_unpressed").frame(width: POWER_SIZE, height: POWER_SIZE)
                Image("power")
            } else {
                Image("Power_base_pressed").frame(width: POWER_SIZE, height: POWER_SIZE)
                Image("power").frame(width: POWER_SIZE, height: POWER_SIZE)
                    .opacity(0.2)
            }
        }.onTapGesture() {
            if clickable {
                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                impactMed.impactOccurred()
                clickable = false
                DeviceManager.default.sendCommandAllOff()
            }
        }.onReceive(button1Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(button2Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(button3Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(button4Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(button5Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(button6Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(button7Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(button8Notif) { (notif) in
            checkPowerButtonClickable()
        }.onReceive(powerNotif) { (notif) in
            checkPowerButtonClickable()
        }
    }
    
    func checkPowerButtonClickable() {
        button1 = DeviceManager.default.getActiveDevice().buttons[0]
        button2 = DeviceManager.default.getActiveDevice().buttons[1]
        button3 = DeviceManager.default.getActiveDevice().buttons[2]
        button4 = DeviceManager.default.getActiveDevice().buttons[3]
        button5 = DeviceManager.default.getActiveDevice().buttons[4]
        button6 = DeviceManager.default.getActiveDevice().buttons[5]
        button7 = DeviceManager.default.getActiveDevice().buttons[6]
        button8 = DeviceManager.default.getActiveDevice().buttons[7]
        var click = false
        if (button1.illuminated || button2.illuminated || button3.illuminated || button4.illuminated || button5.illuminated || button6.illuminated || button7.illuminated || button8.illuminated) {
            click = true
        }
        clickable = click
    }
}
