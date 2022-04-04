//
//  ButtonIconPicker.swift
//  XKcommand
//
//  Created by Tao Zong on 2/7/22.
//

import SwiftUI

struct ButtonIconPicker: View {
    @Environment(\.presentationMode) var presentationMode
    var buttonInfo: ButtonInfo
    var icons: [String] = ["button_icon1", "button_icon2", "button_icon3", "button_icon4", "button_icon5", "button_icon6", "button_icon7", "button_icon8"]
    var items: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                mainBackgroundColor.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: items, spacing: 0) {
                        ForEach(icons, id: \.self) { icon in
                            VStack {
                                PhotoGridView(icon: icon, image: UIImage())
                                    .onTapGesture {
                                        buttonInfo.showType = 1
                                        buttonInfo.showIcon = icon
                                        DeviceManager.default.savePairedDevicesToFile()
                                        presentationMode.wrappedValue.dismiss()
                                    }
                            }
                            .frame(width: geometry.size.width/4, height: geometry.size.width/4)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Preset Icon")
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
