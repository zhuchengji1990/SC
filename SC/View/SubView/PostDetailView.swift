//
//  PostDetailView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/5.
//

import SwiftUI
import LeanCloud

struct PostDetailView: View {
    var obj: LCObject
    var body: some View{
        ScrollView{
            VStack(spacing: 0){
                
                Group{
                    if let file = obj.get("pic") as? LCFile,
                       let url = file.url?.stringValue{
                        URLImage(url: url, radius: 0)
                    }else{
                        Color(.secondarySystemBackground)
                    }
                }.frame(height: 200)
                
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(obj.get("text")?.stringValue ?? "hello").bold()
                        .font(.system(size: 14))
                        .lineLimit(2)
                    
                    
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
                
                Spacer()
                
            }.font(.system(size: 12))
        }
        .navigationBarTitle("详情", displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostDetailView(obj: LCObject())
        }
    }
}
