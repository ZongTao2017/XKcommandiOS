//
//  EditControllerNameView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/31/22.
//

import SwiftUI

struct EditControllerNameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var systemInfo: SystemInfo
    @State var name: String
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            VStack {
                TextField("", text: $name)
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
                Text("Edit Controller Name")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        systemInfo.shortName = name
                        postNotification(.xkDeviceStatus)
                        DeviceManager.default.savePairedDevicesToFile()
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                    }
                }
        }
    }
}
