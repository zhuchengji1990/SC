//
//  PostView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/24.
//

import SwiftUI
import LeanCloud

struct PostView: View {
    var array: [LCObject]
    var body: some View {
        List{
            ForEach(array, id: \.self){ obj in
                PostCell(obj: obj)
            }
        }.listStyle(PlainListStyle())
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(array: [])
    }
}
