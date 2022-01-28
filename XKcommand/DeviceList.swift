//
//  DeviceList.swift
//  XKcommand
//
//  Created by Tao Zong on 1/18/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Device List")
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.top, 100)

            Spacer()
        }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
