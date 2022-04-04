//
//  CustomizeView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct CustomizeView: View {
    @State var deviceInfo: DeviceInfo = DeviceManager.default.getActiveDevice()
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    Spacer()
                    if deviceInfo.state == DeviceState.offline {
                        Text("Device not connected")
                            .frame(height: 30)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                    }
                }
                .frame(height: 60)
                .contentShape(Rectangle())
                NavigationLink(destination: SelectButtonView()) {
                    HStack {
                        Image("Controller_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("Button")
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                            Text("Button actions & linked channels")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80).background(lightGrayBackgroundColor)
                }
                NavigationLink(destination: SelectSensorView()) {
                    HStack {
                        Image("Sensor_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("Sensor Wire")
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                            Text("Sensor actions & linked channels")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80)
                        .background(lightGrayBackgroundColor)
                        .padding(.top)
                }
                NavigationLink(destination: SelectChannelView()) {
                    HStack {
                        Image("Channel_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("Output Channel")
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                            Text("Channel name & max output limit")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80)
                        .background(lightGrayBackgroundColor)
                        .padding(.top)
                }
                NavigationLink(destination: EditSystemView(systemInfo: DeviceManager.default.getSystemInfo())) {
                    HStack {
                        Image("System_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("System")
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                            Text("Controller setup")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80)
                        .background(lightGrayBackgroundColor)
                    .padding(.top)
                    
                }
                Spacer()
            }
        }.onReceive(deviceNotif) { (notif) in
            deviceInfo = DeviceManager.default.getActiveDevice()
        }
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView()
    }
}
