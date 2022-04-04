//
//  ControlView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/21/22.
//

import SwiftUI

let BUTTON_SIZE: CGFloat = 150
let BUTTON_IMAGE_SIZE: CGFloat = 85
let PADDING: CGFloat = 25
let POWER_SIZE: CGFloat = 60

struct ControlDeviceView: View {
    @StateObject var deviceInfo: DeviceInfo
    @StateObject var systemInfo: SystemInfo
    @State private var powerButtonClickable = false
    @State private var showPopUp: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
                .frame(minHeight: 10, idealHeight: 30, maxHeight: 30)
                .fixedSize()
            HStack {
                ControlButton(buttonInfo: deviceInfo.buttons[0])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                ControlButton(buttonInfo: deviceInfo.buttons[1])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
            }
            HStack {
                ControlButton(buttonInfo: deviceInfo.buttons[2])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
                ControlButton(buttonInfo: deviceInfo.buttons[3])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
            }
            PowerButtonView(clickable: powerButtonClickable)
                .frame(width: POWER_SIZE, height: POWER_SIZE)
                .padding(.top, -POWER_SIZE/2-PADDING/2)
                .padding(.bottom, -POWER_SIZE/2)
            HStack {
                ControlButton(buttonInfo: deviceInfo.buttons[4])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
                ControlButton(buttonInfo: deviceInfo.buttons[5])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
            }
            HStack {
                ControlButton(buttonInfo: deviceInfo.buttons[6])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
                ControlButton(buttonInfo: deviceInfo.buttons[7])
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
            }
            ZStack {
                Image("System_Status_base_pressed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_SIZE*2-PADDING)
                    .padding(.top, -PADDING/3)
                HStack {
                    if deviceInfo.systemInfo.volt == 0 {
                        Text("--")
                            .foregroundColor(.gray)
                            .frame(width: 50)
                            .font(.system(size: 24.0))
                    } else {
                        Text(String(format: "%.1fV", deviceInfo.systemInfo.volt))
                            .foregroundColor(.gray)
                            .frame(width: 50)
                            .font(.system(size: 12.0))
                    }
                    
                    Spacer()
                    if deviceInfo.systemInfo.amp == 0 {
                        Text("--")
                            .foregroundColor(.gray)
                            .frame(width: 50)
                            .font(.system(size: 24.0))
                    } else {
                        Text(String(format: "%.1fA", deviceInfo.systemInfo.amp))
                            .foregroundColor(.gray)
                            .frame(width: 50)
                            .font(.system(size: 12.0))
                    }
                    
                    Spacer()
                    if deviceInfo.systemInfo.temperature == Int.min {
                        Text("--")
                            .foregroundColor(.gray)
                            .frame(width: 50)
                            .font(.system(size: 24.0))
                    } else {
                        if deviceInfo.systemInfo.temperatureUnit {
                            Text(String(format: "%d℃", deviceInfo.systemInfo.temperature - 50))
                                .foregroundColor(.gray)
                                .frame(width: 50)
                                .font(.system(size: 12.0))
                        } else {
                            Text(String(format: "%d℉", deviceInfo.systemInfo.temperature - 18))
                                .foregroundColor(.gray)
                                .frame(width: 50)
                                .font(.system(size: 12.0))
                        }
                    }
                    
                }
                .frame(width: BUTTON_SIZE*2-PADDING*2)
                .padding(.top, -PADDING/3)
            }
            
            Spacer()
        }.alert(isPresented: $showPopUp) {
            Alert(title: Text("Warning"), message: Text("Current volt is lower than auto cutoff volt."), dismissButton: .default(Text("OK")))
        }
        .onReceive(button1Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[0].pressed = button!.pressed
            deviceInfo.buttons[0].illuminated = button!.illuminated
            deviceInfo.buttons[0].momentary = button!.momentary
            deviceInfo.buttons[0].bytes = button!.bytes
        }.onReceive(button2Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[1].pressed = button!.pressed
            deviceInfo.buttons[1].illuminated = button!.illuminated
            deviceInfo.buttons[1].momentary = button!.momentary
            deviceInfo.buttons[1].bytes = button!.bytes
        }.onReceive(button3Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[2].pressed = button!.pressed
            deviceInfo.buttons[2].illuminated = button!.illuminated
            deviceInfo.buttons[2].momentary = button!.momentary
            deviceInfo.buttons[2].bytes = button!.bytes
        }.onReceive(button4Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[3].pressed = button!.pressed
            deviceInfo.buttons[3].illuminated = button!.illuminated
            deviceInfo.buttons[3].momentary = button!.momentary
            deviceInfo.buttons[3].bytes = button!.bytes
        }.onReceive(button5Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[4].pressed = button!.pressed
            deviceInfo.buttons[4].illuminated = button!.illuminated
            deviceInfo.buttons[4].momentary = button!.momentary
            deviceInfo.buttons[4].bytes = button!.bytes
        }.onReceive(button6Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[5].pressed = button!.pressed
            deviceInfo.buttons[5].illuminated = button!.illuminated
            deviceInfo.buttons[5].momentary = button!.momentary
            deviceInfo.buttons[5].bytes = button!.bytes
        }.onReceive(button7Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[6].pressed = button!.pressed
            deviceInfo.buttons[6].illuminated = button!.illuminated
            deviceInfo.buttons[6].momentary = button!.momentary
            deviceInfo.buttons[6].bytes = button!.bytes
        }.onReceive(button8Notif) { (notif) in
            let button = notif.object as? ButtonInfo
            deviceInfo.buttons[7].pressed = button!.pressed
            deviceInfo.buttons[7].illuminated = button!.illuminated
            deviceInfo.buttons[7].momentary = button!.momentary
            deviceInfo.buttons[7].bytes = button!.bytes
        }.onReceive(sysNotif) { (notif) in
            let system1 = DeviceManager.default.getActiveDevice().systemInfo
            deviceInfo.systemInfo.volt = system1.volt
            deviceInfo.systemInfo.amp = system1.amp
            deviceInfo.systemInfo.temperature = system1.temperature
        }.onReceive(warnNotif) { (notif) in
            showPopUp = true
        }
    }
}
