//
//  DeviceList.swift
//  XKcommand
//
//  Created by Tao Zong on 1/18/22.
//

import SwiftUI

struct MenuView: View {
    @State var onlineDevices: [DeviceInfo] = []
    @State var offlineDevices: [DeviceInfo] = []
    @State var unpairedDevices: [DeviceInfo] = []
    
    var body: some View {
        ZStack {
            deviceListBackgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Device List")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                            .frame(height: 50)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .background(gray1)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    VStack {
                        ForEach(onlineDevices, id: \.self) { device in
                            PairedDeviceView(deviceInfo: device, systemInfo: device.systemInfo)
                                .padding(.bottom, 1)
                        }
                    }.padding(.bottom, onlineDevices.count > 0 ? 10 : 0)
                    VStack {
                        ForEach(offlineDevices, id: \.self) { device in
                            PairedDeviceView(deviceInfo: device, systemInfo: device.systemInfo)
                                .padding(.bottom, 1)
                        }
                    }
                    HStack {
                        Text("Unpaired")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                            .frame(height: 50)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .background(gray1)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .padding(.top, 70)
                    VStack {
                        ForEach(unpairedDevices, id: \.self) { device in
                            UnpairedDeviceView(deviceInfo: device)
                                .padding(.bottom, 1)
                        }
                    }
                    Spacer()
                }.onReceive(deviceNotif) { (notif) in
                    updateDevices()
                }.onReceive(rssiNotif) { (notif) in
                    updateDevices()
                }.onReceive(currentRssiNotif) { (notif) in
                    updateDevices()
                }.onAppear() {
                    updateDevices()
                }
            }
        }
    }
    
    func updateDevices() {
        DispatchQueue.main.async {
            onlineDevices = []
            offlineDevices = []
            let pairedDevices = DeviceManager.default.getPairedDevices()
            for device in pairedDevices {
                if device.state == DeviceState.offline {
                    if !offlineDevices.contains(device) {
                        offlineDevices.append(device)
                    }
                } else {
                    if !onlineDevices.contains(device) {
                        onlineDevices.append(device)
                    }
                }
            }
            onlineDevices.removeAll(where: {!pairedDevices.contains($0)})
            offlineDevices.removeAll(where: {!pairedDevices.contains($0) || onlineDevices.contains($0)})
            unpairedDevices = DeviceManager.default.getUnpairedDevices()
        }
    }
}
