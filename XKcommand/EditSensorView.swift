//
//  EditSensorView.swift
//  XKcommand
//
//  Created by Tao Zong on 1/27/22.
//

import SwiftUI

struct EditSensorView: View {
    @State private var syncAllChannels = true
    
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
                            Text("Sensor Name")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Text("Sensor 1")
                                .foregroundColor(.gray)
                                .font(.system(size: 20.0))
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        Text("Pink wire labeled with Sensor 1")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 10)
                    }
                    Group {
                        Text("SENSOR FUNCTION")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                        VStack(alignment: .leading, spacing:0) {
                            HStack {
                                Image("radio_unselected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Dim button back light at night")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                                Image(systemName: "info.circle")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                            ExDivider()
                                .padding(.leading, 60)
                            HStack {
                                Image("radio_selected")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text("Trigger output action")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20.0))
                                Spacer()
                                Image(systemName: "info.circle")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            .frame(height: 50)
                        }
                        .background(lightGrayBackgroundColor)
                        .padding(.top, 10)
                    }
                    Group {
                        Text("BUTTON BACK LIGHT")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.top, 40)
                            .padding(.bottom, 10)
                        HStack {
                            Text("Brightness when triggered")
                                .foregroundColor(.white)
                                .font(.system(size: 20.0))
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName:"minus")
                                .foregroundColor(.blue)
                            Text("60%")
                                .foregroundColor(.white)
                            Image(systemName:"plus")
                                .foregroundColor(.blue)
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                        .background(lightGrayBackgroundColor)
                        Text("Only one sensor can be used for button back light dimming function.")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                    }
                    Group {
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
                        Text("A channel can link can link with multiple sensors. If sensors are triggered simutaneously, the order of sensor priority on the same channel is Sensor 1 > 2 > 3.")
                            .foregroundColor(.gray)
                            .font(.system(size: 16.0))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                    }
                    Group {
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
                    }
                    Group {
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
                    }
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
}

struct EditSensorView_Previews: PreviewProvider {
    static var previews: some View {
        EditSensorView()
    }
}
