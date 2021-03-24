//
//  PostCell.swift
//  SC
//
//  Created by 沉寂 on 2021/3/24.
//

import SwiftUI
import LeanCloud

struct PostCell: View {
    var obj: LCObject
    var body: some View{
        HStack(spacing: 10){
            if let file = obj.get("pic") as? LCFile,
               let url = file.url?.stringValue{
                URLImage(url: url, radius: 10)
                    .frame(width: 150, height: 100)
            }
            
            VStack(alignment: .leading){
                
                Text(obj.get("text")?.stringValue ?? "")
                    .font(.system(size: 14))
                    .lineLimit(2)
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    
                    Text(obj.createdAt?.dateValue?.toString() ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.secondaryLabel))
                }
                
            }
        }
        .padding(.vertical, 5)
    }
}


struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(obj: LCObject())
    }
}
