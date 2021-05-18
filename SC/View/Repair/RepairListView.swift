//
//  RepairListView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/11.
//

import SwiftUI
import LeanCloud

struct RepairListView: View {
    @State var objArray: [LCObject] = []
    var body: some View {
        ScrollView{
            VStack(spacing: 1){
                ForEach(objArray, id: \.self) { obj in
                    InfoCell(obj: obj)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .navigationBarTitle("申请记录", displayMode: .inline)
        .onAppear{
            guard let user = Store.shared.user else { return }
            let query = LCQuery(className: "Repair")
            try? query.where("owner", .equalTo(user))
            try? query.where("createdAt", .descending)
            query.find { res in
                switch res{
                case let .success(array):
                    self.objArray = array
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}

struct RepairListView_Previews: PreviewProvider {
    static var previews: some View {
        RepairListView()
    }
}



private struct InfoCell: View{
    var obj: LCObject
    var body: some View{
        HStack(spacing: 10){
            if let file = obj.get("pic") as? LCFile,
               let url = file.url?.stringValue{
                URLImage(url: url, radius: 10)
                    .frame(width: 60, height: 60)
            }
            VStack(alignment: .leading, spacing: 5){
                
                Text(obj.get("address")?.stringValue ?? "").bold()
                    .font(.system(size: 16))
                    .foregroundColor(Color(.label))
                Text(obj.get("text")?.stringValue ?? "")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                
                HStack{
                    Spacer()
                    Text(obj.createdAt?.dateValue?.toString() ?? "2020-01-01 00:00:00")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.secondaryLabel))
                }
            }
        }.padding(20)
        .background(Color(.systemBackground))
    }
}
