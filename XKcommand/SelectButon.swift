//
//  SelectButon.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct SelectButon: View {
    @StateObject var buttonInfo: ButtonInfo
    
    var body: some View {
        NavigationLink(destination: EditButtonView(buttonInfo: buttonInfo)) {
            ZStack {
                Image("Button_unpressed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                if buttonInfo.showType == 1 {
                    Image(buttonInfo.showIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: BUTTON_IMAGE_SIZE, height: BUTTON_IMAGE_SIZE)
                } else if buttonInfo.showType == 2 {
                    Image(uiImage: buttonInfo.showImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: BUTTON_IMAGE_SIZE, height: BUTTON_IMAGE_SIZE)
                        .cornerRadius(5)
                } else if buttonInfo.showType == 3 {
                    Text(buttonInfo.showName)
                        .foregroundColor(.white)
                        .font(Font.custom("impact", size: 20))
                        .lineLimit(3)
                        .frame(maxWidth: BUTTON_IMAGE_SIZE)
                }
            }
        }.onAppear() {
            for button in DeviceManager.default.getActiveDevice().buttons {
                if buttonInfo.buttonId == button.buttonId {
                    buttonInfo.showType = button.showType
                    buttonInfo.showIcon = button.showIcon
                    buttonInfo.showImage = button.showImage
                    buttonInfo.showName = button.showName
                }
            }
        }
    }
}
