//
//  EditChannelView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditChannelView: View {
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
                            Text("Channel Name")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Text("Channel Name 1")
                                .foregroundColor(.gray)
                                .font(.system(size: 20.0))
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                    }
                    Group {
                        Text("PROJECTION")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                        HStack {
                            Text("Max output current")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName:"minus")
                                .foregroundColor(.blue)
                            Text("9A")
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
                    Text("Input a value close to the max operation current of the load on this channel. Once reaching this value, the power of this channel will be immediately cut off.")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 10)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Channel 1")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct EditChannelView_Previews: PreviewProvider {
    static var previews: some View {
        EditChannelView()
    }
}
