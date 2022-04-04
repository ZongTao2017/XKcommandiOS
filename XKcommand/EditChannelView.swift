//
//  EditChannelView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditChannelView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var channelInfo: ChannelInfo
    
    var body: some View {
        ZStack {
            mainBackgroundColor.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 10, maxHeight: 10)
                        .fixedSize()
                    Group {
                        NavigationLink(destination: EditChannelNameView(channelInfo: channelInfo, name: channelInfo.channelName)) {
                            HStack {
                                Text("Channel Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18.0))
                                    .padding(.leading, 20)
                                Spacer()
                                Text(channelInfo.channelName.isEmpty ? String(format: "Channel %d", channelInfo.channelId) : channelInfo.channelName)
                                    .frame(maxWidth: 100, alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 18.0))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                            .background(lightGrayBackgroundColor)
                        }
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
                                .font(.system(size: 18.0))
                                .padding(.leading, 20)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    if channelInfo.maxOutputCurrent > 3 {
                                        channelInfo.maxOutputCurrent -= 1
                                    }
                                }
                            }) {
                                Image(systemName:"minus")
                                    .foregroundColor(channelInfo.maxOutputCurrent <= 3 ? .gray : .blue)
                                    .frame(width: 30, height: 30)
                            }.frame(width: 30, height: 30)
                            Text(String(channelInfo.maxOutputCurrent) + "A")
                                .foregroundColor(.white)
                            Button(action: {
                                withAnimation {
                                    if channelInfo.maxOutputCurrent < 20 {
                                        channelInfo.maxOutputCurrent += 1
                                    }
                                }
                            }) {
                                Image(systemName:"plus")
                                    .foregroundColor(channelInfo.maxOutputCurrent >= 20 ? .gray : .blue)
                                    .frame(width: 30, height: 30)
                            }.frame(width: 30, height: 30).padding(.trailing)
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
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Channel " + String(channelInfo.channelId))
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            DeviceManager.default.sendCommandChannels(channelInfo)
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "chevron.backward")
                        }
                    }
                }
            }
        }
    }
}
