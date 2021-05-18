//
//  CourseDetailView.swift
//  SC
//
//  Created by 沉寂 on 2021/4/13.
//

import SwiftUI
import LeanCloud

struct CourseDetailView: View {
    var obj: LCObject
    var course: LCObject?{
        obj.get("coursePointer") as? LCObject
    }
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                
                InfoCell(title: "名称", content: course?.get("courseName")?.stringValue ?? "")
                InfoCell(title: "教室", content: course?.get("address")?.stringValue ?? "")
                InfoCell(title: "教师", content: course?.get("teacherName")?.stringValue ?? "")
                InfoCell(title: "电话", content: course?.get("phone")?.stringValue ?? "")
                InfoCell(title: "上课时间", content: (obj.get("weekday")?.intValue ?? 0).weekStr + " " + (obj.get("type")?.intValue ?? 0).courseStr)
                InfoCell(title: "备注", content: course?.get("note")?.stringValue ?? "")
                
                
                Spacer()
                
            }.padding(20)
        }
        .background(Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all))
        
        .navigationBarTitle("课程详情", displayMode: .inline)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CourseDetailView(obj: LCObject())
        }
    }
}

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


