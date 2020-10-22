# SwiftUIImagePickerController

Wrapped UIImagePickerController for SwiftUI

example code

//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2020/10/22
//  © 2020  SmallDeskSoftware
//

import SwiftUI
import SwiftUIImagePickerController

struct ContentView: View {
  @State private var image:UIImage? = nil
  @State private var metaData: NSDictionary? = nil
  @State private var showPicker: Bool = false
  
  var body: some View {
    VStack {
      if let image = image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        Button(action: {
          showPicker = true
        }, label: {
          Text("Show picker")
        })
      }
    }
    .fullScreenCover(isPresented: $showPicker, content: {
      SwiftUIImagePickerController(image: $image, metaData: $metaData,
                                   showCameraView: $showPicker)
    })
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

