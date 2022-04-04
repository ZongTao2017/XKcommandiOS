//
//  ButtonImagePicker.swift
//  XKcommand
//
//  Created by Tao Zong on 2/7/22.
//

import SwiftUI
import Photos

struct ButtonImagePicker: View {
    @Environment(\.presentationMode) var presentationMode
    var buttonInfo: ButtonInfo
    @State var images = [UIImage]()
    var items: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                mainBackgroundColor.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: items, spacing: 0) {
                        ForEach(0..<images.count, id: \.self) { i in
                            VStack {
                                if i == 0 {
                                    NavigationLink(destination: CustomCameraView()) {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .foregroundColor(Color.white)
                                            .scaledToFill()
                                            .padding(30)
                                    }
                                } else {
                                    PhotoGridView(icon: "", image: images[i])
                                        .onTapGesture {
                                            buttonInfo.showType = 2
                                            buttonInfo.showImage = images[i]
                                            DeviceManager.default.savePairedDevicesToFile()
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                }
                                
                            }
                            .frame(width: geometry.size.width/4, height: geometry.size.width/4)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Take/Select Photo")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "chevron.backward")
                        }
                    }
            }
            .onAppear() {
                getPhotos()
            }
            .onReceive(cameraNotif) { (notif) in
                buttonInfo.showType = 2
                buttonInfo.showImage = notif.object as! UIImage
                DeviceManager.default.savePairedDevicesToFile()
                presentationMode.wrappedValue.dismiss()
                
            }
        }
    }
    
    fileprivate func getPhotos() {
        images.removeAll()
        images.append(UIImage(systemName: "camera")!)
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 700, height: 700)
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        images.append(image)
                    } else {
                        print("error asset to image")
                    }
                }
            }
        } else {
            print("no photos to display")
        }

    }
}
