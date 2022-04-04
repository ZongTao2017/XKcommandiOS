//
//  ControlButton.swift
//  XKcommand
//
//  Created by Tao Zong on 1/21/22.
//

import SwiftUI

struct ControlButton: View {
    @StateObject var buttonInfo: ButtonInfo
    @State private var canTouchDown = true
    
    var body: some View {
        ZStack {
            if buttonInfo.pressed {
                Image("Button_pressed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
            } else {
                Image("Button_unpressed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
            }
            if buttonInfo.illuminated {
                Image("button_illumination")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
            }
            if buttonInfo.showType == 1 {
                Image(buttonInfo.showIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: BUTTON_IMAGE_SIZE, height: BUTTON_IMAGE_SIZE)
            } else if buttonInfo.showType == 2 {
                Image(uiImage: buttonInfo.showImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: BUTTON_IMAGE_SIZE, height: BUTTON_IMAGE_SIZE)
                    .cornerRadius(5)
            } else if buttonInfo.showType == 3 {
                Text(buttonInfo.showName)
                    .foregroundColor(.white)
                    .font(Font.custom("impact", size: 20))
                    .lineLimit(3)
                    .frame(maxWidth: BUTTON_IMAGE_SIZE)
            }
        }
        .onAppear() {
            for button in DeviceManager.default.getActiveDevice().buttons {
                if buttonInfo.buttonId == button.buttonId {
                    buttonInfo.showType = button.showType
                    buttonInfo.showIcon = button.showIcon
                    buttonInfo.showImage = button.showImage
                    buttonInfo.showName = button.showName
                }
            }
        }
        .onReceive(enableNotif) { (notif) in
            canTouchDown = true
        }
        .onReceive(disableNotif) { (notif) in
            canTouchDown = false
        }
        .gesture(
            DragGesture(minimumDistance: 0).onChanged { value in
                if DeviceManager.default.getActiveDevice().state == DeviceState.ready && DeviceManager.default.getActiveDevice().systemInfo.volt <
                    DeviceManager.default.getActiveDevice().systemInfo.cutoffInputVoltage - 0.001 {
                    postNotification(.xkPopupWarning)
                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
                } else {
                    if canTouchDown {
                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                        impactMed.impactOccurred()
                        buttonInfo.pressed = true
                        if buttonInfo.momentary {
                            buttonInfo.illuminated = true
                        } else {
                            buttonInfo.pressed = true
                            buttonInfo.illuminated = !buttonInfo.illuminated
                        }
                        updateButton()
                    }
                    canTouchDown = false
                }
            }.onEnded { value in
                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                impactMed.impactOccurred()
                buttonInfo.pressed = false
                if buttonInfo.momentary {
                    buttonInfo.illuminated = false
                    updateButton()
                }
                canTouchDown = true
            })
            
    }
    
    func updateButton() {
        postNotification(.xkPowerStatus)
        if buttonInfo.bytes.isEmpty {
            return
        }
        buttonInfo.bytes[0] = setBit(buttonInfo.illuminated, index: 0, of: buttonInfo.bytes[0])
        buttonInfo.bytes[0] = setBit(true, index: 3, of: buttonInfo.bytes[0])
        buttonInfo.bytes[0] = setBit(false, index: 7, of: buttonInfo.bytes[0])
        DeviceManager.default.sendCommandButton(buttonInfo)
    }
}
