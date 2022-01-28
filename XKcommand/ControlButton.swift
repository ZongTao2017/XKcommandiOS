//
//  ControlButton.swift
//  XKcommand
//
//  Created by Tao Zong on 1/21/22.
//

import SwiftUI

struct ControlButton: View {
    @Binding var buttonId: Int
    
    var body: some View {
        ZStack {
            Image("Button_unpressed")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
            Image("Button_pressed")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
            Image("button_illumination")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
        }
    }
}

struct ControlButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlButton(buttonId: .constant(0))
    }
}
