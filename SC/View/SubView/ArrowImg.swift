//
//  ArrowImg.swift
//  CommunitySwiftUI
//
//  Created by 沉寂 on 2020/7/11.
//  Copyright © 2020 Berry. All rights reserved.
//

import SwiftUI

struct ArrowImg: View {
    var direction: Direction = .right
    
    enum Direction: String{
        case up
        case down
        case left
        case right
    }
    
    var body: some View {
        Image(systemName: "chevron.\(direction.rawValue)")
            .resizable()
            .foregroundColor(Color(.secondaryLabel))
            .frame(width: 8, height: 14)
    }
}

struct ArrowImg_Previews: PreviewProvider {
    static var previews: some View {
        ArrowImg()
    }
}
