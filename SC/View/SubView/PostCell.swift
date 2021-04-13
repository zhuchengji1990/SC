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
            
            Group{
                if let file = obj.get("pic") as? LCFile,
                   let url = file.url?.stringValue{
                    URLImage(url: url, radius: 10)
                }else{
                    Color(.secondarySystemBackground)
                }
            }.frame(width: 200, height: 150)
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10){
                
                Text(obj.get("text")?.stringValue ?? "hello")
                    .font(.system(size: 14))
                    .lineLimit(2)
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    
                    Text(obj.createdAt?.dateValue?.toString() ?? "2020-01-01 00:00:00")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.secondaryLabel))
                }
                
                HStack(spacing: 0){
                    
                    Spacer()
                    
                    Image(systemName: "text.bubble")
                        .frame(width: 34, height: 34)
                    
                    Text("0")
                        .padding(.trailing, 10)
                    
                    
                    Image(systemName: "suit.heart")
                        .frame(width: 34, height: 34)
                    
                    Text("0")
                }
            }
        }
        .frame(height: 150)
        .padding(10)
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color(.secondarySystemBackground), lineWidth: 1.0, antialiased: true))
        
    }
}


struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(obj: LCObject())
            
            .padding(20)
    }
}
