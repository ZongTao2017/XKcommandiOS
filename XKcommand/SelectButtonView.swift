//
//  SelectButtonView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct SelectButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 30, maxHeight: 30)
                    .fixedSize()
                HStack {
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[0])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[1])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                }
                HStack {
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[2])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[3])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                }
                HStack {
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[4])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[5])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                }
                HStack {
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[6])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                    SelectButon(buttonInfo: DeviceManager.default.getActiveDevice().buttons[7])
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Button")
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

struct SelectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SelectButtonView()
    }
}
