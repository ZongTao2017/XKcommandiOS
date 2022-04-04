//
//  ColorPickerView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/9/22.
//

import SwiftUI

struct ColorPickerView: View, SquarePickerDelegate {
    @Environment(\.presentationMode) var presentationMode
    var type: Int
    @State var color: UIColor
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            VStack {
                ColorPicker(color: color, delegate: self)
                    .frame(height: 300)
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Choose Color")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        switch type {
                        case 1:
                            DeviceManager.default.getActiveDevice().systemInfo.buttonColor = color
                        default:
                            DeviceManager.default.getActiveDevice().systemInfo.buttonWarningColor = color
                        }
                        DeviceManager.default.updateSystemSetting()
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                    }
                }
        }
    }
    
    func colorChanged(newColor: UIColor) {
        color = newColor
    }
}
