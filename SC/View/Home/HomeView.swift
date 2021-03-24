//
//  HomeView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ScrollView{
            VStack(spacing: 0){
                
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(10)
                
                HStack{
                    NavigationLink(destination: AnnouncementView()){
                        TypeCell(title: "学校公告", imgName: "bell", color: Color(.systemRed))
                    }
                    
                    Spacer()
                    TypeCell(title: "成绩查询", imgName: "bell", color: Color(.systemOrange))
                    Spacer()
                    
                    TypeCell(title: "课程", imgName: "bell", color: Color(.systemYellow))
                    
                    Spacer()
                    TypeCell(title: "调温", imgName: "bell", color: Color(.systemGreen))
                }.padding(10)
                
                HStack{
                    
                    TypeCell(title: "待办事项", imgName: "bell", color: Color(.systemTeal))
                    Spacer()
                    TypeCell(title: "请假", imgName: "bell", color: Color(.systemPurple))
                    Spacer()
                    TypeCell(title: "表白", imgName: "bell", color: Color(.systemBlue))
                    Spacer()
                    TypeCell(title: "报修", imgName: "bell", color: Color(.systemIndigo))
                    
                }.padding(10)
                
                Divider()
                
                
                ForEach(0..<20){ index in
                    InfoCell(title: "待办事项\(index)")
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("首页", displayMode: .inline)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct TypeCell: View{
    
    var title: String
    var imgName: String
    var color: Color
    var body: some View{
        VStack(spacing: 5){
            
            Image(systemName: imgName)
                .imageScale(.large)
                .frame(width: 54, height: 54)
                .background(color)
                .clipShape(Circle())
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
        }.frame(width: 80)
    }
    
    
}

private struct InfoCell: View {
    var title: String
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Text(title)
                Spacer()
            }.padding(20)
            Divider()
        }
        
    }
}
