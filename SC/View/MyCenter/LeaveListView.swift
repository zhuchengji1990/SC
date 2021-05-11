//
//  LeaveListView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/11.
//

import SwiftUI
import LeanCloud

struct LeaveListView: View {
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
            let query = LCQuery(className: "Leave")
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

struct LeaveListView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveListView()
    }
}



private struct InfoCell: View{
    var obj: LCObject
    var body: some View{
        VStack(alignment: .leading, spacing: 5){
                
            Text("\(obj.get("startDate")?.dateValue?.toString("yyyy-MM-dd") ?? "") ~ \(obj.get("endDate")?.dateValue?.toString("yyyy-MM-dd") ?? "")").bold()
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
            }.padding(20)
        .background(Color(.systemBackground))
    }
}
