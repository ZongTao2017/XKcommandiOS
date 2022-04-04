//
//  EditSensorView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditSensorView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var sensorInfo: ButtonInfo
    @StateObject var systemInfo: SystemInfo
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 10, maxHeight: 10)
                        .fixedSize()
                    Group {
                        NavigationLink(destination: EditSensorNameView(sensorInfo: sensorInfo, name: sensorInfo.sensorName)) {
                            HStack {
                                Text("Sensor Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                Spacer()
                                Text(sensorInfo.sensorName)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 18.0))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                            .background(lightGrayBackgroundColor)
                        }
                        
                        Text("Pink wire labeled with Sensor 1")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 10)
                    }
                    Group {
                        Text("SENSOR FUNCTION")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                        VStack(alignment: .leading, spacing:0) {
                            HStack {
                                if sensorInfo.dim {
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
                                        .opacity(DeviceManager.default.checkIfHasDim() && !sensorInfo.dim ? 0.3 : 1.0)
                                }
                                
                                Text("Dim button back light at night")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .opacity(DeviceManager.default.checkIfHasDim() && !sensorInfo.dim ? 0.3 : 1.0)
                                Spacer()
                                Image(systemName: "info.circle")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if !DeviceManager.default.checkIfHasDim() {
                                    sensorInfo.dim = true
                                }
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                            HStack {
                                if !sensorInfo.dim {
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
                                Text("Trigger output action")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                Spacer()
                                Image(systemName: "info.circle")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                sensorInfo.dim = false
                            }
                            .frame(height: 50)
                        }
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 10)
                    }
                    if sensorInfo.dim {
                        Group {
                            Text("BUTTON BACK LIGHT")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                                .padding(.leading, 20)
                                .padding(.top, 40)
                                .padding(.bottom, 10)
                            HStack {
                                Text("Brightness when triggered")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        if systemInfo.dimPercent > 20 {
                                            systemInfo.dimPercent -= 5
                                        }
                                    }
                                }) {
                                    Image(systemName:"minus")
                                        .foregroundColor(systemInfo.dimPercent <= 20 ? .gray : .blue)
                                        .frame(width: 30, height: 30)
                                }.frame(width: 30, height: 30)
                                Text(String(systemInfo.dimPercent) + "%")
                                    .foregroundColor(.white)
                                Button(action: {
                                    withAnimation {
                                        if systemInfo.dimPercent < 100 {
                                            systemInfo.dimPercent += 5
                                        }
                                    }
                                }) {
                                    Image(systemName:"plus")
                                        .foregroundColor(systemInfo.dimPercent >= 100 ? .gray : .blue)
                                        .frame(width: 30, height: 30)
                                }.frame(width: 30, height: 30).padding(.trailing)
                            }
                            .frame(height: 50)
                            .background(lightGrayBackgroundColor)
                            Text("Only one sensor can be used for button back light dimming function.")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)
                        }
                    } else {
                        Group {
                            Text("LINKED CHANNELS")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                                .padding(.leading, 20)
                                .padding(.top, 40)
                                .padding(.bottom, 10)
                            VStack (alignment: .leading, spacing:0) {
                                Group {
                                    HStack {
                                        if sensorInfo.channels[0] {
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
                                        sensorInfo.channels[0].toggle()
                                    }
                                    .frame(height: 50)
                                    ExDivider()
                                        .padding(.leading, 60)
                                }
                                Group {
                                    HStack {
                                        if sensorInfo.channels[1] {
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
                                                .onTapGesture {
                                                    sensorInfo.channels[1] = true
                                                }
                                        }
                                        Text("Channel 2")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18.0))
                                        Spacer()
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        sensorInfo.channels[1].toggle()
                                    }
                                    .frame(height: 50)
                                    ExDivider()
                                        .padding(.leading, 60)
                                }
                                Group {
                                    HStack {
                                        if sensorInfo.channels[2] {
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
                                        sensorInfo.channels[2].toggle()
                                    }
                                    .frame(height: 50)
                                    ExDivider()
                                        .padding(.leading, 60)
                                }
                                Group {
                                    HStack {
                                        if sensorInfo.channels[3] {
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
                                        sensorInfo.channels[3].toggle()
                                    }
                                    .frame(height: 50)
                                    ExDivider()
                                        .padding(.leading, 60)
                                }
                                Group {
                                    HStack {
                                        if sensorInfo.channels[4] {
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
                                        sensorInfo.channels[4].toggle()
                                    }
                                    .frame(height: 50)
                                    ExDivider()
                                        .padding(.leading, 60)
                                }
                                Group {
                                    HStack {
                                        if sensorInfo.channels[5] {
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
                                        sensorInfo.channels[5].toggle()
                                    }
                                    .frame(height: 50)
                                    ExDivider()
                                        .padding(.leading, 60)
                                }
                                Group {
                                    HStack {
                                        if sensorInfo.channels[6] {
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
                                        sensorInfo.channels[6].toggle()
                                    }
                                    .frame(height: 50)
                                    ExDivider()
                                        .padding(.leading, 60)
                                }
                                Group {
                                    HStack {
                                        if sensorInfo.channels[7] {
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
                                        sensorInfo.channels[7].toggle()
                                    }
                                    .frame(height: 50)
                                }
                            }.background(lightGrayBackgroundColor)
                            Text("A channel can link can link with multiple sensors. If sensors are triggered simutaneously, the order of sensor priority on the same channel is Sensor 1 > 2 > 3.")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)
                        }
                        Group {
                            Text("SYNC ALL CHANNELS")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                                .padding(.leading, 20)
                                .padding(.top, 40)
                                .padding(.bottom, 10)
                            VStack (alignment: .leading, spacing:0) {
                                Toggle(isOn: $sensorInfo.sync) {
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
                        }
                        VStack {
                            if sensorInfo.sync {
                                ActionView(channelId: 0, buttonInfo: sensorInfo)
                            } else {
                                Group {
                                    if (sensorInfo.channels[0]) {
                                        ActionView(channelId: 1, buttonInfo: sensorInfo)
                                    }
                                    if (sensorInfo.channels[1]) {
                                        ActionView(channelId: 2, buttonInfo: sensorInfo)
                                    }
                                    if (sensorInfo.channels[2]) {
                                        ActionView(channelId: 3, buttonInfo: sensorInfo)
                                    }
                                    if (sensorInfo.channels[3]) {
                                        ActionView(channelId: 4, buttonInfo: sensorInfo)
                                    }
                                }
                                Group {
                                    if (sensorInfo.channels[4]) {
                                        ActionView(channelId: 5, buttonInfo: sensorInfo)
                                    }
                                    if (sensorInfo.channels[5]) {
                                        ActionView(channelId: 6, buttonInfo: sensorInfo)
                                    }
                                    if (sensorInfo.channels[6]) {
                                        ActionView(channelId: 7, buttonInfo: sensorInfo)
                                    }
                                    if (sensorInfo.channels[7]) {
                                        ActionView(channelId: 8, buttonInfo: sensorInfo)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Sensor " + String(sensorInfo.buttonId))
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            updateSensorSetting()
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "chevron.backward")
                        }
                    }
                }
            }
        }
    }
    
    func updateSensorSetting() {
        if sensorInfo.bytes.isEmpty {
            return
        }
        sensorInfo.bytes[0] = setBit(true, index: 4, of: sensorInfo.bytes[0])
        sensorInfo.bytes[0] = setBit(true, index: 5, of: sensorInfo.bytes[0])
        sensorInfo.bytes[0] = setBit(sensorInfo.dim, index: 6, of: sensorInfo.bytes[0])
        sensorInfo.bytes[0] = setBit(true, index: 7, of: sensorInfo.bytes[0])
        for (index, channel) in sensorInfo.channels.enumerated() {
            if channel {
                sensorInfo.bytes[1 + index] = UInt8(sensorInfo.actions[index])
            } else {
                sensorInfo.bytes[1 + index] = 0
            }
        }
        DeviceManager.default.sendCommandSensor(sensorInfo)
        if sensorInfo.dim {
            systemInfo.bytes[2] = UInt8(systemInfo.dimPercent * 255 / 100)
            DeviceManager.default.sendCommandUserSetting(systemInfo)
        }
        
    }
}
