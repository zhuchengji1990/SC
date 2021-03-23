//
//  PicImg.swift
//  CommunitySwiftUI
//
//  Created by 沉寂 on 2020/7/22.
//  Copyright © 2020 Berry. All rights reserved.
//

import SwiftUI
import Kingfisher

struct URLImage: View {
    var url: String?
    var radius: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            Group{
                if let str = url,
                   str.count > 0,
                   let url = URL(string: str + "?imageView2/0/w/\(Int(geo.size.width * UIScreen.main.scale))"){
                    KFImage(url)
                        .resizable()
                        .cancelOnDisappear(true)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .cornerRadius(self.radius)
                }else{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .cornerRadius(self.radius)
                        .foregroundColor(Color(.white))
                }
            }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage()
    }
}
