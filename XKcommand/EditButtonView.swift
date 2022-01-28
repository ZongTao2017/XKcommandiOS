//
//  EditButtonView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditButtonView: View {
    @State private var switchMomentary = true
    @State private var syncAllChannels = true
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            ScrollView {
                VStack (alignment: .leading, spacing:0) {
                    Text("BUTTON ICON")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.top, 40)
                        .padding(.bottom, 10)
                    VStack (alignment: .leading, spacing:0) {
                        HStack {
                            Image("radio_selected")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .padding(.leading, 20)
                            Text("Select preset icon")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        ExDivider()
                            .padding(.leading, 60)
                        HStack {
                            Image("radio_unselected")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .padding(.leading, 20)
                            Text("Take/select photo")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        ExDivider()
                            .padding(.leading, 60)
                        HStack {
                            Image("radio_unselected")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .padding(.leading, 20)
                            Text("Use name")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        ExDivider()
                            .padding(.leading, 60)
                        HStack {
                            Image("radio_unselected")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .padding(.leading, 20)
                            Text("N/A")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                    }.background(lightGrayBackgroundColor)
                    Text("LINKED CHANNELS")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.top, 40)
                        .padding(.bottom, 10)
                    VStack (alignment: .leading, spacing:0) {
                        Group {
                            HStack {
                                Image("check_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 1")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                        }
                        Group {
                            HStack {
                                Image("check_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 2")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                        }
                        Group {
                            HStack {
                                Image("check_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 3")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                        }
                        Group {
                            HStack {
                                Image("check_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 4")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                        }
                        Group {
                            HStack {
                                Image("check_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 5")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                        }
                        Group {
                            HStack {
                                Image("check_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 6")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                        }
                        Group {
                            HStack {
                                Image("check_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 7")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                        }
                        Group {
                            HStack {
                                Image("check_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Channel 8")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                            }
                            .frame(height: 50)
                        }
                    }.background(lightGrayBackgroundColor)
                    Text("MOMENTARY SWITCH")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.top, 40)
                        .padding(.bottom, 10)
                    VStack (alignment: .leading, spacing:0) {
                        Toggle(isOn: $switchMomentary) {
                            Text("Turn off when button is released")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    .frame(height: 50)
                    .background(lightGrayBackgroundColor)
                    Text("SYNC ALL CHANNELS")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.top, 40)
                        .padding(.bottom, 10)
                    VStack (alignment: .leading, spacing:0) {
                        Toggle(isOn: $syncAllChannels) {
                            Text("Same action for all linked channels")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    .frame(height: 50)
                    .background(lightGrayBackgroundColor)
                    Text("ACTION")
                        .foregroundColor(.gray)
                        .font(.system(size: 16.0))
                        .padding(.leading, 20)
                        .padding(.top, 40)
                        .padding(.bottom, 10)
                    VStack (alignment: .leading, spacing:0) {
                        Group {
                            Group {
                                HStack {
                                    Image("radio_selected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("Full On")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("Triple Burst Flash A")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("Triple Burst Flash B")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("Single Flash A")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("Single Flash B")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("Turn Signal Flash A")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("Turn Signal Flash B")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                        }
                        Group {
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("90% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("80% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("70% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("60% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("50% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("40% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("30% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                                ExDivider()
                                    .padding(.leading, 60)
                            }
                            Group {
                                HStack {
                                    Image("radio_unselected")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading, 20)
                                    Text("20% power on")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20.0))
                                    Spacer()
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Button 1")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
    }
}

struct EditButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditButtonView()
    }
}

struct ExDivider: View {
    let color: Color = Color(red: 59 / 255, green: 59 / 255, blue: 59 / 255)
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
