//
//  ScheduleDetailView.swift
//  SC
//
//  Created by 沉寂 on 2021/4/13.
//

import SwiftUI
import LeanCloud

struct ScheduleDetailView: View {
    var obj: LCObject
    
    var courseName: String{
        let course = obj.get("coursePointer") as? LCObject
        return course?.get("courseName")?.stringValue ?? ""
    }
    
    @State var isFinish: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                
                InfoCell(title: "内容", content: obj.get("content")?.stringValue ?? "")
                InfoCell(title: "所属课程", content: courseName)
                InfoCell(title: "时间", content: obj.get("startDate")?.dateValue?.toString() ?? "")
                
                Group{
                    if isFinish{
                        Button(action: {
                            try? obj.set("isFinish", value: false)
                            obj.save { res in
                                self.isFinish = false
                            }
                        }) {
                            Text("已完成")
                                .frame(width: 120, height: 44)
                                .background(Color(.systemGreen))
                                .cornerRadius(22)
                        }
                    }else{
                        Button(action: {
                            try? obj.set("isFinish", value: true)
                            obj.save { res in
                                self.isFinish = true
                            }
                        }) {
                            Text("未完成")
                                .frame(width: 120, height: 44)
                                .background(Color(.systemRed))
                                .cornerRadius(22)
                        }
                    }
                }.foregroundColor(Color.white)
                
                
                
                Spacer()
                
            }.padding(20)
        }
        .background(Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all))
        .navigationBarTitle("待办详情", displayMode: .inline)
        .onAppear{
            self.isFinish = obj.get("isFinish")?.boolValue ?? false
        }
    }
}

//struct ScheduleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//        ScheduleDetailView()
//        }
//    }
//}



private struct InfoCell: View {
    var title: String
    var content: String
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            
            Text(content)
                .foregroundColor(Color(.secondaryLabel))
            
        }.frame(height: 54)
        .padding(.horizontal, 20)
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}

