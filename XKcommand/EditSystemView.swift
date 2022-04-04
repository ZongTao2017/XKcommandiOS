//
//  EditSystemView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditSystemView: View {
    @Environment(\.presentationMode) var presentationMode
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
                        NavigationLink(destination: EditControllerNameView(systemInfo: systemInfo, name: systemInfo.shortName)) {
                            HStack {
                                Text("Controller Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                Spacer()
                                Text(systemInfo.shortName)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 18.0))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                            .background(lightGrayBackgroundColor)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        }
                    }
                    Group {
                        HStack {
                            Text("Auto Cutoff Input Voltage")
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                                .padding(.leading, 20)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    if systemInfo.cutoffInputVoltage > 11.1 {
                                        systemInfo.cutoffInputVoltage -= 0.2
                                    }
                                }
                            }) {
                                Image(systemName:"minus")
                                    .foregroundColor(systemInfo.cutoffInputVoltage < 11.1 ? .gray : .blue)
                                    .frame(width: 30, height: 30)
                            }.frame(width: 30, height: 30)
                            Text(String(format: "%.1fV", systemInfo.cutoffInputVoltage))
                                .foregroundColor(.white)
                            Button(action: {
                                withAnimation {
                                    if systemInfo.cutoffInputVoltage < 12.8 {
                                        systemInfo.cutoffInputVoltage += 0.2
                                    }
                                }
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(systemInfo.cutoffInputVoltage > 12.9 ? .gray : .blue)
                                    .frame(width: 30, height: 30)
                            }.frame(width: 30, height: 30).padding(.trailing)
                                
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 10)
                    }
                    Text("When system detects the input power is less than the set value, the entire system will be shut off to conserve battery power.")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    Group {
                        VStack (alignment: .leading, spacing:0) {
                            Toggle(isOn: $systemInfo.bluetoothAutoOff) {
                                Text("Bluetooth Auto Off")
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
                            if systemInfo.bluetoothAutoOff {
                                HStack {
                                    Text("Turn Off Bluetooth After")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18.0))
                                        .padding(.leading, 20)
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            if systemInfo.bluetoothOffTime > 1 {
                                                systemInfo.bluetoothOffTime -= 1
                                            }
                                        }
                                    }) {
                                        Image(systemName:"minus")
                                            .foregroundColor(systemInfo.bluetoothOffTime <= 1 ? .gray : .blue)
                                            .frame(width: 30, height: 30)
                                    }.frame(width: 30, height: 30)
                                    Text(String(systemInfo.bluetoothOffTime) + "min")
                                        .foregroundColor(.white)
                                    Button(action: {
                                        withAnimation {
                                            if systemInfo.bluetoothOffTime < 240 {
                                                systemInfo.bluetoothOffTime += 1
                                            }
                                        }
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(systemInfo.bluetoothOffTime >= 240 ? .gray : .blue)
                                            .frame(width: 30, height: 30)
                                    }.frame(width: 30, height: 30).padding(.trailing)
                                }
                                .frame(height: 50)
                                .background(lightGrayBackgroundColor)
                                .padding(.top, 2)
                                Text("If all channels are off and controller is not connected to a device via bluetooth, after the set time value, bluetooth will be cut off to conserve power consumption. To revoke the system, press any control panel button.")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16.0))
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.top, 10)
                            }
                        }.padding(.bottom, 20)
                    }
                    Group {
                        HStack {
                            Text("Temperature Unit")
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                                .padding(.leading, 20)
                            Spacer()
                            if systemInfo.temperatureUnit {
                                Text(String(format: "℃"))
                                    .foregroundColor(.blue)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                Text("/")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                Text(String(format: "℉"))
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .frame(width: 30)
                                    .padding(.trailing)
                                    .onTapGesture() {
                                        systemInfo.temperatureUnit = false
                                    }
                            } else {
                                Text(String(format: "℃"))
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                    .onTapGesture() {
                                        systemInfo.temperatureUnit = true
                                    }
                                Text("/")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                Text(String(format: "℉"))
                                    .foregroundColor(.blue)
                                    .font(.system(size: 18.0))
                                    .frame(width: 30)
                                    .padding(.trailing)
                            }
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 10)
                        NavigationLink(destination: ColorPickerView(type: 1, color: systemInfo.buttonColor)) {
                            HStack {
                                Text("Button Color")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                Spacer()
                                VStack{}
                                    .frame(width: 30, height: 30)
                                    .background(Color(systemInfo.buttonColor))
                                    .cornerRadius(5)
                                    .padding(.trailing)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                            .background(lightGrayBackgroundColor)
                            .padding(.top, 40)
                        }
                        
                        Text("Button backlight LED color when it is on.")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                    }
                    Group {
                        NavigationLink(destination: ColorPickerView(type: 2, color: systemInfo.buttonWarningColor)) {
                            HStack {
                                Text("Button Warning Color")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                Spacer()
                                VStack{}
                                    .frame(width: 30, height: 30)
                                    .background(Color(systemInfo.buttonWarningColor))
                                    .cornerRadius(5)
                                    .padding(.trailing)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                            .background(lightGrayBackgroundColor)
                            .padding(.top, 20)
                        }
                        Text("Button backlight LED color when certain channel it links to is cut due to exceeding set safety current.")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("System")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            DeviceManager.default.updateSystemSetting()
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "chevron.backward")
                        }
                    }
                }
            }
        }
    }
}
