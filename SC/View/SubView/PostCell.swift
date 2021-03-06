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
    
    @State var isActive = false
    var body: some View{
        
        ZStack{
            NavigationLink(destination: PostDetailView(obj: obj), isActive: $isActive){
                EmptyView()
            }.hidden()
            HStack(spacing: 0){
                
                Group{
                    if let file = obj.get("pic") as? LCFile,
                       let url = file.url?.stringValue{
                        URLImage(url: url, radius: 10)
                    }else{
                        Color(.secondarySystemBackground)
                    }
                }.frame(width: 150, height: 100)
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(obj.get("text")?.stringValue ?? "hello").bold()
                        .font(.system(size: 14))
                        .lineLimit(2)
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        
                        Text(obj.createdAt?.dateValue?.toString() ?? "2020-01-01 00:00:00")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    
                    HStack(spacing: 0){
                        
                        Spacer()
                        
                        Image(systemName: "text.bubble")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .frame(width: 24, height: 24)
                        
                        Text("0")
                            .padding(.trailing, 10)
                        
                        
                        Image(systemName: "suit.heart")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .frame(width: 24, height: 24)
                        
                        Text("0")
                    }
                }.padding(10)
            }.font(.system(size: 12))
            .frame(height: 100)
            .background(Color(.systemBackground))
            .onTapGesture {
                self.isActive.toggle()
            }
        }
    }
}


struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(obj: LCObject())
            
            .padding(20)
    }
}
