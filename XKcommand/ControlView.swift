//
//  ControlView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/21/22.
//

import SwiftUI

let BUTTON_SIZE: CGFloat = 170
let PADDING: CGFloat = 25
let POWER_SIZE: CGFloat = 60

struct ControlView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(minHeight: 10, idealHeight: 70, maxHeight: 70)
                .fixedSize()
            HStack {
                ControlButton(buttonId: .constant(1))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                ControlButton(buttonId: .constant(2))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
            }
            HStack {
                ControlButton(buttonId: .constant(3))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
                ControlButton(buttonId: .constant(4))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
            }
            ZStack {
                Image("Power_base_unpressed").frame(width: POWER_SIZE, height: POWER_SIZE)
                    .padding(.top, -POWER_SIZE/2-PADDING/2)
                    .padding(.bottom, -POWER_SIZE/2)
                Image("power").frame(width: POWER_SIZE, height: POWER_SIZE)
                    .padding(.top, -POWER_SIZE/2-PADDING/2)
                    .padding(.bottom, -POWER_SIZE/2)
            }
            
            HStack {
                ControlButton(buttonId: .constant(5))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
                ControlButton(buttonId: .constant(6))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
            }
            HStack {
                ControlButton(buttonId: .constant(7))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
                ControlButton(buttonId: .constant(8))
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    .padding(.top, -PADDING)
            }
            Image("System_Status_base_pressed")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: BUTTON_SIZE*2-PADDING)
                .padding(.top, -PADDING/3)
            Spacer()
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
    }
}
