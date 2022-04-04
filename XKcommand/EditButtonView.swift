//
//  EditButtonView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var buttonInfo: ButtonInfo
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            GeometryReader { geometry in
                ScrollView {
                    VStack (alignment: .leading, spacing:0) {
                        Text("BUTTON ICON")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                            .padding(.bottom, 10)
                        VStack (alignment: .leading, spacing:0) {
                            ZStack {
                                HStack {
                                    if buttonInfo.showType == 1 {
                                        Image("radio_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("radio_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Select preset icon")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                    Image(buttonInfo.showIcon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(5)
                                        .padding(.trailing)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                }
                                .frame(height: 50)
                                HStack {
                                    if buttonInfo.showIcon.isEmpty {
                                        NavigationLink(destination: ButtonIconPicker(buttonInfo: buttonInfo)) {
                                            VStack{}
                                            .frame(width: geometry.size.width, height: 50)
                                            .contentShape(Rectangle())
                                        }
                                    } else {
                                        VStack{}
                                        .frame(width: geometry.size.width/2, height: 50)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            buttonInfo.showType = 1
                                            DeviceManager.default.savePairedDevicesToFile()
                                        }
                                        NavigationLink(destination: ButtonIconPicker(buttonInfo: buttonInfo)) {
                                            VStack{}
                                            .frame(width: geometry.size.width/2, height: 50)
                                            .contentShape(Rectangle())
                                        }
                                    }
                                }
                            }.frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                            ZStack {
                                HStack {
                                    if buttonInfo.showType == 2 {
                                        Image("radio_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("radio_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Take/select photo")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                    Image(uiImage: buttonInfo.showImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(5)
                                        .padding(.trailing)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                }
                                .frame(height: 50)
                                HStack {
                                    if buttonInfo.showImage.size.width == 0 {
                                        NavigationLink(destination: ButtonImagePicker(buttonInfo: buttonInfo)) {
                                            VStack{}
                                            .frame(width: geometry.size.width, height: 50)
                                            .contentShape(Rectangle())
                                        }
                                    } else {
                                        VStack{}
                                        .frame(width: geometry.size.width/2, height: 50)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            buttonInfo.showType = 2
                                            DeviceManager.default.savePairedDevicesToFile()
                                        }
                                        NavigationLink(destination: ButtonImagePicker(buttonInfo: buttonInfo)) {
                                            VStack{}
                                            .frame(width: geometry.size.width/2, height: 50)
                                            .contentShape(Rectangle())
                                        }
                                    }
                                }
                            }.frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                            ZStack {
                                HStack {
                                    if buttonInfo.showType == 3 {
                                        Image("radio_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("radio_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Use name")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                    Text(buttonInfo.showName)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 100, alignment: .trailing)
                                        .font(.system(size: 18.0))
                                        .lineLimit(1)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                }
                                .frame(height: 50)
                                HStack {
                                    if buttonInfo.showName.isEmpty {
                                        NavigationLink(destination: ButtonNameView(buttonInfo: buttonInfo, name: buttonInfo.showName)) {
                                            VStack{}
                                            .frame(width: geometry.size.width, height: 50)
                                            .contentShape(Rectangle())
                                        }
                                    } else {
                                        VStack{}
                                        .frame(width: geometry.size.width/2, height: 50)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            buttonInfo.showType = 3
                                            DeviceManager.default.savePairedDevicesToFile()
                                        }
                                        NavigationLink(destination: ButtonNameView(buttonInfo: buttonInfo, name: buttonInfo.showName)) {
                                            VStack{}
                                            .frame(width: geometry.size.width/2, height: 50)
                                            .contentShape(Rectangle())
                                        }
                                    }
                                }
                            }.frame(height: 50)
                                .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                            HStack {
                                if buttonInfo.showType == 4 {
                                    Image("radio_selected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                } else {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                }
                                
                                Text("N/A")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                buttonInfo.showType = 4
                                DeviceManager.default.savePairedDevicesToFile()
                            }
                        }.background(lightGrayBackgroundColor)
                        Text("LINKED CHANNELS")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                            .padding(.bottom, 10)
                        VStack (alignment: .leading, spacing:0) {
                            Group {
                                HStack {
                                    if buttonInfo.channels[0] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 1")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[0].toggle()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    if buttonInfo.channels[1] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 2")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[1].toggle()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    if buttonInfo.channels[2] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 3")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[2].toggle()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    if buttonInfo.channels[3] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 4")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[3].toggle()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    if buttonInfo.channels[4] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 5")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[4].toggle()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    if buttonInfo.channels[5] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 6")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[5].toggle()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    if buttonInfo.channels[6] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 7")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[6].toggle()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    if buttonInfo.channels[7] {
                                        Image("check_selected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    } else {
                                        Image("check_unselected")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                    }
                                    Text("Channel 8")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    buttonInfo.channels[7].toggle()
                                }
                                .frame(height: 50)
                                
                            }
                        }.background(lightGrayBackgroundColor)
                        Text("MOMENTARY SWITCH")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                            .padding(.bottom, 10)
                        VStack (alignment: .leading, spacing:0) {
                            Toggle(isOn: $buttonInfo.momentary) {
                                Text("Turn off when button is released")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        Text("SYNC ALL CHANNELS")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                            .padding(.bottom, 10)
                        VStack (alignment: .leading, spacing:0) {
                            Toggle(isOn: $buttonInfo.sync) {
                                Text("Same action for all linked channels")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        VStack {
                            if buttonInfo.sync {
                                ActionView(channelId: 0, buttonInfo: buttonInfo)
                            } else {
                                Group {
                                    if (buttonInfo.channels[0]) {
                                        ActionView(channelId: 1, buttonInfo: buttonInfo)
                                    }
                                    if (buttonInfo.channels[1]) {
                                        ActionView(channelId: 2, buttonInfo: buttonInfo)
                                    }
                                    if (buttonInfo.channels[2]) {
                                        ActionView(channelId: 3, buttonInfo: buttonInfo)
                                    }
                                    if (buttonInfo.channels[3]) {
                                        ActionView(channelId: 4, buttonInfo: buttonInfo)
                                    }
                                }
                                Group {
                                    if (buttonInfo.channels[4]) {
                                        ActionView(channelId: 5, buttonInfo: buttonInfo)
                                    }
                                    if (buttonInfo.channels[5]) {
                                        ActionView(channelId: 6, buttonInfo: buttonInfo)
                                    }
                                    if (buttonInfo.channels[6]) {
                                        ActionView(channelId: 7, buttonInfo: buttonInfo)
                                    }
                                    if (buttonInfo.channels[7]) {
                                        ActionView(channelId: 8, buttonInfo: buttonInfo)
                                    }
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Button " + String(buttonInfo.buttonId))
                        .font(.title3)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        updateButtonSetting()
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                    }
                }
            }
        }
    }
    
    func updateButtonSetting() {
        DeviceManager.default.savePairedDevicesToFile()
        if buttonInfo.bytes.isEmpty {
            return
        }
        buttonInfo.bytes[0] = setBit(false, index: 3, of: buttonInfo.bytes[0])
        buttonInfo.bytes[0] = setBit(buttonInfo.momentary, index: 4, of: buttonInfo.bytes[0])
        buttonInfo.bytes[0] = setBit(true, index: 5, of: buttonInfo.bytes[0])
        buttonInfo.bytes[0] = setBit(false, index: 6, of: buttonInfo.bytes[0])
        buttonInfo.bytes[0] = setBit(true, index: 7, of: buttonInfo.bytes[0])
        for (index, channel) in buttonInfo.channels.enumerated() {
            if channel {
                buttonInfo.bytes[1 + index] = UInt8(buttonInfo.actions[index])
            } else {
                buttonInfo.bytes[1 + index] = 0
            }
        }
        DeviceManager.default.sendCommandButton(buttonInfo)
    }
}

struct ExDivider: View {
    let color: Color = Color(red: 59 / 255, green: 59 / 255, blue: 59 / 255)
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}


