//
//  SelectSensorView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct SelectSensorView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 10, maxHeight: 10)
                    .fixedSize()
                VStack(alignment: .leading, spacing:0) {
                    NavigationLink(destination: EditSensorView(sensorInfo: DeviceManager.default.getSensorInfo(1), systemInfo: DeviceManager.default.getSystemInfo())) {
                        HStack {
                            Text(DeviceManager.default.getSensorInfo(1).sensorName)
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }.frame(height: 50)
                    }
                    ExDivider()
                        .padding(.leading, 20)
                    NavigationLink(destination: EditSensorView(sensorInfo: DeviceManager.default.getSensorInfo(2), systemInfo: DeviceManager.default.getSystemInfo())) {
                        HStack {
                            Text(DeviceManager.default.getSensorInfo(2).sensorName)
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }.frame(height: 50)
                    }
                    ExDivider()
                        .padding(.leading, 20)
                    NavigationLink(destination: EditSensorView(sensorInfo: DeviceManager.default.getSensorInfo(3), systemInfo: DeviceManager.default.getSystemInfo())) {
                        HStack {
                            Text(DeviceManager.default.getSensorInfo(3).sensorName)
                                .foregroundColor(.white)
                                .font(.system(size: 18.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }.frame(height: 50)
                    }
                }
                .background(lightGrayBackgroundColor)
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Sensor")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "chevron.backward")
                        }
                    }
            }
        }
    }
}
