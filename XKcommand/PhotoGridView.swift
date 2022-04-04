//
//  PhotoGridView.swift
//  XKcommand
//
//  Created by Tao Zong on 2/7/22.
//

import SwiftUI

struct PhotoGridView: View {
    var icon: String
    var image: UIImage
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                mainBackgroundColor.ignoresSafeArea()
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width*2/3, height: geometry.size.width*2/3, alignment: .center)
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                    .clipped()
                    
            }
        }
    }
}
