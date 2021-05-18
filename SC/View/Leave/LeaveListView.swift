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
                    InfoCell(obj: obj){
                        loadList()
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .navigationBarTitle("申请记录", displayMode: .inline)
        .onAppear{
           loadList()
        }
    }
    
    func loadList(){
        guard let user = Store.shared.user else { return }
        self.objArray = []
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

struct LeaveListView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveListView()
    }
}



private struct InfoCell: View{
    var obj: LCObject
    var completion: () -> Void
    
    @State var note = ""
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            
            Text("\(obj.get("startDate")?.dateValue?.toString("yyyy-MM-dd") ?? "") ~ \(obj.get("endDate")?.dateValue?.toString("yyyy-MM-dd") ?? "")").bold()
                .font(.system(size: 16))
                .foregroundColor(Color(.label))
            Text(obj.get("text")?.stringValue ?? "")
                .font(.system(size: 14))
                .foregroundColor(Color(.secondaryLabel))
            
            HStack{
                Group{
                    switch obj.get("status")?.intValue ?? 0{
                    case 0:
                        Text("待审核")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(.systemOrange))
                    case 1:
                        Text("已通过")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(.systemGreen))
                    default:
                        Text("已拒绝")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(.systemRed))
                    }
                }.font(.system(size: 12))
                .foregroundColor(Color(.white))
                .cornerRadius(4)
                
                Text(obj.get("note")?.stringValue ?? "")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                
                Spacer()
//                Text(obj.createdAt?.dateValue?.toString() ?? "2020-01-01 00:00:00")
//                    .font(.system(size: 12))
//                    .foregroundColor(Color(.secondaryLabel))
            }
            
            if Store.shared.role != .student{
                VStack(spacing: 10){
                    Color(.secondarySystemBackground).frame(height: 1)
                    
                    TextField("请输入通过或拒绝理由", text: $note)
                        .frame(height: 44)
                        .padding(.horizontal, 10)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(4)
                    
                    HStack(spacing: 20){
                        
                        Button(action: {
                            self.endEditing()
                            try? obj.set("note", value: note)
                            try? obj.set("status", value: 1)
                            _ = obj.save(completion: { _ in
                                completion()
                            })
                        }) {
                            Text("通过")
                                .frame(width: 100, height: 44)
                                .background(Color(.systemGreen))
                                .cornerRadius(22)
                        }
                        
                        Button(action: {
                            self.endEditing()
                            try? obj.set("note", value: note)
                            try? obj.set("status", value: 2)
                            _ = obj.save(completion: { _ in
                                completion()
                            })
                        }) {
                            Text("拒绝")
                                .frame(width: 100, height: 44)
                                .background(Color(.systemRed))
                                .cornerRadius(22)
                        }
                    }.font(.system(size: 14))
                    .foregroundColor(Color(.white))
                }
            }
        }.padding(20)
        .background(Color(.systemBackground))
    }
}


