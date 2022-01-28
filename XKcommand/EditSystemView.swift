//
//  EditSystemView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditSystemView: View {
    @State private var bluetoothAutoOff = true
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 10, maxHeight: 10)
                        .fixedSize()
                    Group {
                        HStack {
                            Text("Controller Name")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Text("XKGLOW_6666")
                                .foregroundColor(.gray)
                                .font(.system(size: 20.0))
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    }
                    Group {
                        HStack {
                            Text("Auto Cutoff Input Voltage")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName:"minus")
                                .foregroundColor(.blue)
                            Text("12.0V")
                                .foregroundColor(.white)
                            Image(systemName:"plus")
                                .foregroundColor(.blue)
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 10)
                    }
                    Text("When system detects the input power is less than the set value, the entire system will be shut off to conserve battery power.")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    Group {
                        VStack (alignment: .leading, spacing:0) {
                            Toggle(isOn: $bluetoothAutoOff) {
                                Text("Bluetooth Auto Off")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        HStack {
                            Text("Turn Off Bluetooth After")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName:"minus")
                                .foregroundColor(.blue)
                            Text("120min")
                                .foregroundColor(.white)
                            Image(systemName:"plus")
                                .foregroundColor(.blue)
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 2)
                        Text("If all channels are off and controller is not connected to a device via bluetooth, after the set time value, bluetooth will be cut off to conserve power consumption. To revoke the system, press any control panel button.")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                    }
                    Group {
                        HStack {
                            Text("Button Color")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 10)
                        Text("Button backlight LED color when it is on.")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                    }
                    Group {
                        HStack {
                            Text("Button Warning Color")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 20)
                        Text("Button backlight LED color when certain channel it links to is cut due to exceeding set safety current.")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("System")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct EditSystemView_Previews: PreviewProvider {
    static var previews: some View {
        EditSystemView()
    }
}
