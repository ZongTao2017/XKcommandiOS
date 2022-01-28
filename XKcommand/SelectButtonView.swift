//
//  SelectButtonView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct SelectButtonView: View {
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 30, maxHeight: 30)
                    .fixedSize()
                HStack {
                    SelectButon(buttonId: .constant(1))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                    SelectButon(buttonId: .constant(2))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                }
                HStack {
                    SelectButon(buttonId: .constant(3))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                    SelectButon(buttonId: .constant(4))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                }
                HStack {
                    SelectButon(buttonId: .constant(5))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                    SelectButon(buttonId: .constant(6))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                }
                HStack {
                    SelectButon(buttonId: .constant(7))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                    SelectButon(buttonId: .constant(8))
                        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                        .padding(.top, -PADDING)
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Button")
                        .font(.title3)
                        .foregroundColor(.white)
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
