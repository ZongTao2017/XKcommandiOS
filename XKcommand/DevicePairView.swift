//
//  DevicePairView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/11/22.
//

import SwiftUI

struct DevicePairView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var signal: Float = 0
    @State var count: Int = 0
    @State var show: Bool = false
    
    var device: DeviceInfo
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            PairingProximity(signal: $signal, count: $count)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Pairing...")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        if show {
                            Text("Done")
                        }
                    }
                }
            ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DeviceManager.default.removeDevice(device)
                        presentationMode.wrappedValue.dismiss()
                    }){
                        if !show {
                            Text("Cancel")
                        }
                    }
                }
        }.onReceive(currentRssiNotif) { (notif) in
            signal = device.getSignal()
            if (signal >= 1) {
                count += 1
            }
        }.onReceive(donePairNotif) { (notif) in
            show = true
        }.onAppear() {
            DeviceManager.default.setActiveDevice(device)
        }
    }
}
