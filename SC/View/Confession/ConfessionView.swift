//
//  ConfessionView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI
import LeanCloud

struct ConfessionView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Post>{
        $store.appState.post
    }
    
    var body: some View {
        
        List{
            ForEach(binding.array.wrappedValue
                        .filter{ $0.get("type")?.stringValue == Store.PublishType.confession.rawValue },
                    id: \.self){ obj in
                
                PostCell(obj: obj)
            }
        }.listStyle(PlainListStyle())
        .navigationBarTitle("表白墙", displayMode: .inline)
    }
}

struct ConfessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionView().environmentObject(Store.shared)
    }
}

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
                    
                    Text(obj.createdAt?.isoString ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.secondaryLabel))
                }
                
            }
        }
        .padding(.vertical, 5)
    }
}
