//
//  CustomizeView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct CustomizeView: View {
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 10, maxHeight: 10)
                    .fixedSize()
                NavigationLink(destination: SelectButtonView()) {
                    HStack {
                        Image("Controller_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("Button")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Text("Button actions & linked channels")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80).background(lightGrayBackgroundColor)
                }
                NavigationLink(destination: SelectSensorView()) {
                    HStack {
                        Image("Sensor_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("Sensor Wire")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Text("Sensor actions & linked channels")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80)
                        .background(lightGrayBackgroundColor)
                        .padding(.top)
                }
                NavigationLink(destination: SelectChannelView()) {
                    HStack {
                        Image("Channel_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("Output Channel")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Text("Channel name & max output limit")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80)
                        .background(lightGrayBackgroundColor)
                        .padding(.top)
                }
                NavigationLink(destination: EditSystemView()) {
                    HStack {
                        Image("System_Edit_Icon")
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("System")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Text("Controller setup")
                                .foregroundColor(.gray)
                                .font(.system(size: 16.0))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }.frame(height: 80)
                        .background(lightGrayBackgroundColor)
                    .padding(.top)
                    
                }
                Spacer()
            }
        }
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView()
    }
}
