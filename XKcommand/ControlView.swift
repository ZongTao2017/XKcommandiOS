//
//  ControlDeviceView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/27/22.
//

import SwiftUI

struct ControlView: View {
    @State var offset: CGFloat = 0
    @State var devices: [DeviceInfo] = [DeviceInfo]()
    @State var showArrows = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                if offset < 0 && showArrows {
                    Button(action: {
                        withAnimation {
                            offset += geometry.size.width
                            let index: Int = Int(-offset / geometry.size.width)
                            DeviceManager.default.setSelectedDevice(newId: devices[index].uuid)
                        }
                    }) {
                        Image("triangle_left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12)
                    }.frame(width: 30)
                }
                if offset > CGFloat((1 - devices.count)) * geometry.size.width && showArrows {
                    Button(action: {
                        withAnimation {
                            offset -= geometry.size.width
                            let index: Int = Int(-offset / geometry.size.width)
                            DeviceManager.default.setSelectedDevice(newId: devices[index].uuid)
                        }
                    }) {
                        Image("triangle_right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12)
                    }
                    .frame(width: 30)
                    .offset(x: geometry.size.width - 30)
                }
                HStack(spacing: 0) {
                    ForEach(0..<devices.count, id: \.self) { i in
                        ControlDeviceView(deviceInfo: devices[i], systemInfo: devices[i].systemInfo)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }.offset(x: offset)
            }
            .onAppear() {
                updateDevices(width: geometry.size.width)
            }
            .onReceive(deviceNotif) { (notif) in
                updateDevices(width: geometry.size.width)
                
            }.onReceive(enableNotif) { (notif) in
                showArrows = true
            }
            .onReceive(disableNotif) { (notif) in
                showArrows = false
            }
        }
    }
    
    func updateDevices(width: CGFloat) {
        let pairedDevices = DeviceManager.default.getPairedDevices()
        var offlineDevices = [DeviceInfo]()
        for device in pairedDevices {
            if device.state == DeviceState.offline {
                if device.state == DeviceState.offline {
                    if !offlineDevices.contains(device) {
                        offlineDevices.append(device)
                    }
                    
                } else {
                    if !devices.contains(device) {
                        devices.append(device)
                    }
                }
            }
        }
        devices.removeAll(where: {!pairedDevices.contains($0)})
        if devices.isEmpty {
            if !offlineDevices.isEmpty {
                devices.append(offlineDevices[0])
            } else {
                devices.append(DeviceManager.default.getActiveDevice())
            }
            
        }
        for (index, device) in devices.enumerated() {
            if device.uuid == DeviceManager.default.getActiveDevice().uuid {
                withAnimation {
                    offset = -CGFloat(index) * width
                }
            }
        }
    }
}
