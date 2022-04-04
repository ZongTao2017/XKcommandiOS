//
//  EditSensorNameView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/24/22.
//

import SwiftUI

struct EditSensorNameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var sensorInfo: ButtonInfo
    @State var name: String
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            VStack {
                TextField("", text: $name)
                    .placeholder(when: name.isEmpty) {
                            Text(String(format:"Sensor %d", sensorInfo.buttonId)).foregroundColor(gray1)
                    }
                    .foregroundColor(Color.white)
                    .font(.system(size: 18))
                    .textFieldStyle(DefaultTextFieldStyle())
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                ExDivider()
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                Spacer()
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit Sensor Name")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        sensorInfo.sensorName = name
                        DeviceManager.default.savePairedDevicesToFile()
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                    }
                }
        }
    }
}
