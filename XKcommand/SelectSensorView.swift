//
//  SelectSensorView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct SelectSensorView: View {
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 10, maxHeight: 10)
                    .fixedSize()
                VStack(alignment: .leading, spacing:0) {
                    NavigationLink(destination: EditSensorView()) {
                        HStack {
                            Text("Sensor Name 1")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }.frame(height: 50)
                    }
                    ExDivider()
                        .padding(.leading, 20)
                    NavigationLink(destination: EditSensorView()) {
                        HStack {
                            Text("Sensor Name 2")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }.frame(height: 50)
                    }
                    ExDivider()
                        .padding(.leading, 20)
                    NavigationLink(destination: EditSensorView()) {
                        HStack {
                            Text("Sensor Name 3")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }.frame(height: 50)
                    }
                }
                .background(lightGrayBackgroundColor)
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Sensor")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct SelectSensorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSensorView()
    }
}
