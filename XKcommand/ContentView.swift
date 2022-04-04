//
//  ContentView.swift
//  XKcommand
//
//  Created by Tao Zong on 11/23/21.
//

import SwiftUI

let mainBackgroundColor = Color(red: 36 / 255, green: 36 / 255, blue: 36 / 255)
let lightGrayBackgroundColor = Color(red: 49 / 255, green: 49 / 255, blue: 49 / 255)
let blue1 = Color(red: 29 / 255, green: 68 / 255, blue: 98 / 255)
let blue2 = Color(red: 29 / 255, green: 55 / 255, blue: 74 / 255)
let blue3 = Color(red: 0 / 255, green: 115 / 255, blue: 188 / 255)
let blue4 = Color(red: 0 / 255, green: 82 / 255, blue: 128 / 255)
let gray1 = Color(red: 59 / 255, green: 59 / 255, blue: 59 / 255)
let gray2 = Color(red: 81 / 255, green: 81 / 255, blue: 81 / 255)
let deviceListBackgroundColor = Color(red: 37 / 255, green: 37 / 255, blue: 37 / 255)

struct ContentView: View {
    @State var currentDevice: DeviceInfo = DeviceManager.default.getActiveDevice()
    @State var showMenu = false
    @State var offset: CGFloat = 0
    @State var dragging: Bool = false
    
    var body: some View {
        let drag = DragGesture()
            .onChanged{ gesture in
                dragging = true
                offset = gesture.translation.width
            }
            .onEnded { _ in
                if offset > 100 {
                    withAnimation {
                        showMenu = false
                    }
                    dragging = false
                    postNotification(.xkHideDeviceList)
                } else {
                    withAnimation {
                        showMenu = true
                    }
                    dragging = false
                }
                offset = 0
            }
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.gray],
            for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white],
            for: .selected)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = UIColor(mainBackgroundColor)
        UITabBar.appearance().barTintColor = UIColor(mainBackgroundColor)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(mainBackgroundColor)
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        return NavigationView {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ZStack {
                        VStack{}
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(Color.clear)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if showMenu {
                                    withAnimation {
                                        showMenu = false
                                    }
                                    postNotification(.xkHideDeviceList)
                                }
                            }
                        MainView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .disabled(showMenu)
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                    MenuView()
                        .frame(width: geometry.size.width*5/6)
                }
                .offset(x: showMenu ? (dragging ? clamp(offset, 0, geometry.size.width*5/6) - geometry.size.width*5/6 : -geometry.size.width*5/6) : 0)
                .navigationBarTitle("", displayMode: .inline)
                .gesture(drag)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("XKGLOW_Logo")
                            .frame(width: 132, height: 24)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if !showMenu {
                                postNotification(.xkShowDeviceList)
                            } else {
                                postNotification(.xkHideDeviceList)
                            }
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image("Device_list")
                                .frame(width: 20, height: 20)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if currentDevice.rssi > -70 {
                            Image("BLT3")
                                .frame(width: 20, height: 20)
                        } else if (currentDevice.rssi > -90) {
                            Image("BLT2")
                                .frame(width: 20, height: 20)
                        } else if (currentDevice.rssi > -120) {
                            Image("BLT1")
                                .frame(width: 20, height: 20)
                        } else {
                            Image("BLT0")
                                .frame(width: 20, height: 20)
                        }
                        
                    }
                }
                .onReceive(deviceNotif) { (notif) in
                    currentDevice = DeviceManager.default.getActiveDevice()
                }
            }
        }
    }
}

struct MainView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ZStack {
                //                Image("Background")
                //                    .resizable()
                //                    .scaledToFill()
                //                    .edgesIgnoringSafeArea(.all)
                mainBackgroundColor.ignoresSafeArea()
                ControlView()
            }
            .tabItem {
                selection == 0 ? Image("Control_selected") : Image("Control_Unselected")
                Text("Control")
            }.tag(0)
            
            CustomizeView()
                .tabItem {
                    selection == 1 ? Image("Customize_selected") : Image("Customize_Unselected")
                    Text("Customize")
                }.tag(1)
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Circle")
                }
            }
            .tabItem {
                selection == 2 ? Image("Circle_selected") : Image("Circle_Unselected")
                Text("Circle")
            }.tag(2)
        }
    }
}
