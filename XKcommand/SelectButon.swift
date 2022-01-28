//
//  SelectButon.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct SelectButon: View {
    @Binding var buttonId: Int
    
    var body: some View {
        NavigationLink(destination: EditButtonView()) {
            ZStack {
                Image("Button_unpressed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                Text("Button " + String(buttonId))
                    .foregroundColor(.white)
                    .font(Font.custom("impact", size: 20))
            }
        }
    }
}

struct SelectButon_Previews: PreviewProvider {
    static var previews: some View {
        SelectButon(buttonId: .constant(0))
    }
}
