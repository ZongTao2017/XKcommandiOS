//
//  XKcommandApp.swift
//  XKcommand
//
//  Created by Tao Zong on 11/23/21.
//

import SwiftUI

@main
struct XKcommandApp: App {
    @Environment(\.scenePhase) private var scenePhase
    private var loaded: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                print("App state: background")
            case .active:
                print("App state: active")
                DeviceManager.default.loadPairedDevices()
                DeviceManager.default.startScanTimer()
            case .inactive:
                print("App state: inactive")
                DeviceManager.default.stopScanTimer()
            default:
                print("App state: unknown")
            }
        }
    }
}
