//
//  UnpairedDeviceView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/8/22.
//

import SwiftUI

struct UnpairedDeviceView: View {
    @StateObject var deviceInfo: DeviceInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink(destination: DevicePairView(device: deviceInfo)) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(deviceInfo.systemInfo.shortName)
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                            .frame(height: 50, alignment: .leading)
                            .padding(.leading, 20)
                        Spacer()
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
                    .background(gray2)
                    .frame(height: 50)
                    HStack {
                        VStack {
                            Text("8-button Control Panel")
                                .foregroundColor(.white)
                                .font(.system(size: 14.0))
                                .frame(height: 30, alignment: .leading)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Text("Tap to pair")
                                .foregroundColor(.white)
                                .font(.system(size: 14.0))
                                .frame(width: 100, height: 30)
                            Spacer()
                        }
                    }
                    .background(gray2)
                    .frame(height: 20)
                }
            }.frame(height: 70)
        }
    }
}
