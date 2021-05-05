//
//  CourseDetailView.swift
//  SC
//
//  Created by 沉寂 on 2021/4/13.
//

import SwiftUI

struct CourseDetailView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                CourseCell(title: "课程")
                
                InfoCell(title: "教师", content: "陈老师")
                InfoCell(title: "电话", content: "13011110000")
                InfoCell(title: "课程类型", content: "公开课")
                InfoCell(title: "上课时间", content: "2021-01-01 00:00")
                InfoCell(title: "下课时间", content: "2021-01-01 00:00")
                InfoCell(title: "通知", content: "院长旁听")
                InfoCell(title: "必带物品", content: "电脑、作业本")
                
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
            CourseDetailView()
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


