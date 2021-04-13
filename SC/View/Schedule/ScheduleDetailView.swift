//
//  ScheduleDetailView.swift
//  SC
//
//  Created by 沉寂 on 2021/4/13.
//

import SwiftUI

struct ScheduleDetailView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ScheduleCell(title: "课程")
                
                InfoCell(title: "所属课程", content: "C语言")
                InfoCell(title: "时间", content: "2021-01-01 00:00")
                
                
                Spacer()
                
            }.padding(20)
        }
        .background(Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all))
        
        .navigationBarTitle("待办详情", displayMode: .inline)
    }
}

struct ScheduleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ScheduleDetailView()
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

