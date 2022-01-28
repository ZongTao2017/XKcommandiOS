//
//  ContentView.swift
//  XKcommand
//
//  Created by Tao Zong on 11/23/21.
//

import SwiftUI

let backgroundColor = Color(red: 36 / 255, green: 36 / 255, blue: 36 / 255)
let lightGrayBackgroundColor = Color(red: 49 / 255, green: 49 / 255, blue: 49 / 255)

struct ContentView: View {
    
    @State var showMenu = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white],
           for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
           [NSAttributedString.Key.foregroundColor: UIColor.white],
           for: .selected)
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width*3/4)
                            .transition(.move(edge: .leading))
                    }
                }
                    .gesture(drag)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Image("XKGLOW_Logo")
                                .frame(width: 132, height: 24)
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                withAnimation {
                                    self.showMenu.toggle()
                                }
                            }) {
                                Image("Device_list")
                                    .frame(width: 20, height: 20)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Image("BLT0")
                                .frame(width: 20, height: 20)
                        }
                    }
            }
        }
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ControlView()
            }
                .tabItem {
                    selection == 0 ? Image("Control_selected") : Image("Control_Unselected")
                    Text("Control")
                }.tag(0)
            
            CustomizeView()
                .tabItem {
                    selection == 1 ? Image("Customize_selected") : Image("Customize_Unselected")
                    Text("Customize")
                }.tag(1)
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Circle")
                }
            }
                .tabItem {
                    selection == 2 ? Image("Circle_selected") : Image("Circle_Unselected")
                    Text("Circle")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
