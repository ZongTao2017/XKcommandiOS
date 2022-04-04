//
//  PairedDeviceView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/8/22.
//

import SwiftUI

struct PairedDeviceView: View {
    @StateObject var deviceInfo: DeviceInfo
    @StateObject var systemInfo: SystemInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(systemInfo.shortName)
                    .foregroundColor(.white)
                    .font(.system(size: 18.0))
                    .frame(height: 50, alignment: .leading)
                    .padding(.leading, 20)
                Spacer()
                if deviceInfo.state == DeviceState.offline {
                    VStack {
                        Image("BLT0")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                    }.frame(width: 100, height: 50)
                } else {
                    if deviceInfo.rssi > -70 {
                        VStack {
                            Image("BLT3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }.frame(width: 100, height: 50)
                    } else if (deviceInfo.rssi > -90) {
                        VStack {
                            Image("BLT2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }.frame(width: 100, height: 50)
                    } else if (deviceInfo.rssi > -120) {
                        VStack {
                            Image("BLT1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }.frame(width: 100, height: 50)
                    } else {
                        VStack {
                            Image("BLT0")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }.frame(width: 100, height: 50)
                    }
                }
            }
            .background(deviceInfo.state == DeviceState.offline ? gray2 : deviceInfo.uuid == DeviceManager.default.getActiveDevice().uuid ? blue3 : blue1)
            .frame(height: 50)
            HStack {
                Text("8-button Control Panel")
                    .foregroundColor(.white)
                    .font(.system(size: 14.0))
                    .frame(height: 30, alignment: .leading)
                    .padding(.leading, 20)
                Spacer()
                Text(deviceInfo.state.asString)
                    .foregroundColor(.white)
                    .font(.system(size: 14.0))
                    .frame(width: 100, height: 30)
            }
            .background(deviceInfo.state == DeviceState.offline ? gray2 : deviceInfo.uuid == DeviceManager.default.getActiveDevice().uuid ? blue4 : blue2)
            .frame(height: 30)
        }
        .onTapGesture {
            if deviceInfo.uuid != DeviceManager.default.getActiveDevice().uuid &&
                deviceInfo.state == DeviceState.discovered {
                DeviceManager.default.setSelectedDevice(newId: deviceInfo.uuid)
            }
        }
        .onSwipe(trailing: [
            Slot(
                image: {
                    Image("localImageName")
                        // To allow colorifying
                        .renderingMode(.template)
                },
                title: {
                    Text("Unpair")
                        .foregroundColor(.white)
                        .embedInAnyView()
                    
                },
                action: { DeviceManager.default.removeDevice(deviceInfo) },
                style: .init(background: .red)
            )
        ])
        .clipped()
    }
}
