//
//  ActionView.swift
//  XKcommand
//
//  Created by Tao Zong on 2/28/22.
//

import SwiftUI

struct ActionView: View {
    var channelId: Int
    @StateObject var buttonInfo: ButtonInfo
    
    var body: some View {
        VStack (alignment: .leading, spacing:0) {
            if channelId == 1 {
                Text("ACTION - CHANNEL 1")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else if channelId == 2 {
                Text("ACTION - CHANNEL 2")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else if channelId == 3 {
                Text("ACTION - CHANNEL 3")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else if channelId == 4 {
                Text("ACTION - CHANNEL 4")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else if channelId == 5 {
                Text("ACTION - CHANNEL 5")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else if channelId == 6 {
                Text("ACTION - CHANNEL 6")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else if channelId == 7 {
                Text("ACTION - CHANNEL 7")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else if channelId == 8 {
                Text("ACTION - CHANNEL 8")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            } else {
                Text("ACTION - ALL CHANNELS")
                    .foregroundColor(.gray)
                    .font(.system(size: 16.0))
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            }
            Group {
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(1) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 1 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("Full On")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(1)
                        } else {
                            buttonInfo.actions[channelId - 1] = 1
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(2) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 2 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("Triple Burst Flash A")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(2)
                        } else {
                            buttonInfo.actions[channelId - 1] = 2
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(3) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 3 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("Triple Burst Flash B")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(3)
                        } else {
                            buttonInfo.actions[channelId - 1] = 3
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(4) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 4 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("Single Flash A")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(4)
                        } else {
                            buttonInfo.actions[channelId - 1] = 4
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(5) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 5 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("Single Flash B")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(5)
                        } else {
                            buttonInfo.actions[channelId - 1] = 5
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(6) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 6 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("Turn Signal Flash A")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(6)
                        } else {
                            buttonInfo.actions[channelId - 1] = 6
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(7) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                .onTapGesture {
                                    setAction(7)
                                }
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 7 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("Turn Signal Flash B")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(7)
                        } else {
                            buttonInfo.actions[channelId - 1] = 7
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
            }
            Group {
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(230) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 230 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("90% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(230)
                        } else {
                            buttonInfo.actions[channelId - 1] = 230
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(204) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 204 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("80% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(204)
                        } else {
                            buttonInfo.actions[channelId - 1] = 204
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(179) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 179 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("70% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(179)
                        } else {
                            buttonInfo.actions[channelId - 1] = 179
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(153) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 153 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("60% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(153)
                        } else {
                            buttonInfo.actions[channelId - 1] = 153
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(128) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 128 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("50% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(128)
                        } else {
                            buttonInfo.actions[channelId - 1] = 128
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(102) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 102 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("40% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(102)
                        } else {
                            buttonInfo.actions[channelId - 1] = 102
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(77) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 77 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("30% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(77)
                        } else {
                            buttonInfo.actions[channelId - 1] = 77
                        }
                    }
                    .frame(height: 50)
                    ExDivider()
                        .padding(.leading, 60)
                }
                Group {
                    HStack {
                        if channelId == 0 {
                            if checkAction(51) {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        } else {
                            if buttonInfo.actions[channelId - 1] == 51 {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            } else {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                            }
                        }
                        Text("20% power on")
                            .foregroundColor(.white)
                            .font(.system(size: 18.0))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if channelId == 0 {
                            setAction(51)
                        } else {
                            buttonInfo.actions[channelId - 1] = 51
                        }
                    }
                    .frame(height: 50)
                }
            }
        }
    }
    
    func checkAction(_ actionId: Int) -> Bool {
        for (index, channel) in buttonInfo.channels.enumerated() {
            if channel {
                if buttonInfo.actions[index] == actionId {
                    return true
                }
            }
        }
        return false
    }
    
    func setAction(_ actionId: Int) {
        for (index, channel) in buttonInfo.channels.enumerated() {
            if channel {
                buttonInfo.actions[index] = actionId
            }
        }
    }
}
