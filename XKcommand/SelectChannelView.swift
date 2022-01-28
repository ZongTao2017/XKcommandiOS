//
//  SelectChannelView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct SelectChannelView: View {
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(alignment: .leading, spacing:0) {
                Spacer()
                    .frame(minHeight: 10, idealHeight: 10, maxHeight: 10)
                    .fixedSize()
                VStack(alignment: .leading, spacing:0) {
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 1")
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
                    }
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 2")
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
                    }
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 3")
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
                    }
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 4")
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
                    }
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 5")
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
                    }
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 6")
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
                    }
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 7")
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
                    }
                    Group {
                        NavigationLink(destination: EditChannelView()) {
                            HStack {
                                Text("Channel 8")
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
                }
                .background(lightGrayBackgroundColor)
                .padding(.top, 20)
                Text("Setup the name and max current limit for each channel.")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Channel")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct SelectChannelView_Previews: PreviewProvider {
    static var previews: some View {
        SelectChannelView()
    }
}
