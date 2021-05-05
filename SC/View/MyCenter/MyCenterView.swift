//
//  MyCenterView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI

struct MyCenterView: View {
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.MyCenter>{
        $store.appState.myCenter
    }
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 0){
                
                InfoView()
                
                VStack(spacing: 0){
                    NavigationLink(destination: AnnouncementView()){
                        InfoCell(title: "学校公告", imgName: "bell")
                    }
                    NavigationLink(destination: TodoListView()){
                        InfoCell(title: "待办事项", imgName: "list.number")
                    }
                    NavigationLink(destination: LeaveView()){
                        InfoCell(title: "请假", imgName: "envelope")
                    }
                }
                
                VStack(spacing: 0){
                    NavigationLink(destination: QueryScoreView()){
                        InfoCell(title: "成绩查询", imgName: "doc.text.magnifyingglass")
                    }
                    NavigationLink(destination: TemperatureView()){
                        InfoCell(title: "调温", imgName: "thermometer.sun")
                    }
                    NavigationLink(destination: RepairView()){
                        InfoCell(title: "报修", imgName: "wrench.and.screwdriver")
                    }
                    NavigationLink(destination: SettingView()){
                        InfoCell(title: "设置", imgName: "gear")
                    }
                }
            }
        }.navigationBarTitle("我的", displayMode: .inline)
    }
}

struct MyCenterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MyCenterView().environmentObject(Store.shared)
        }
        
    }
}


private struct InfoView: View{
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.MyCenter>{
        $store.appState.myCenter
    }
    
    @State var isImagePickerPresented = false
    @State var isLoginPresented = false
    
    var unloggedInView: some View{
        HStack(spacing: 10){
            Image(systemName:"person.crop.circle")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(Color.theme)
                .clipShape(Circle())
                .shadow(radius: 5)
            Text(binding.username.wrappedValue.localizedString).bold()
                .font(.system(size: 24))
                .foregroundColor(Color(.label))
            
            Spacer()
            
        }.frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
    
    var loggedInView: some View{
        HStack(spacing: 10){
            Image(systemName:"person.crop.circle")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(Color.theme)
                .clipShape(Circle())
                .shadow(radius: 5)
            
            Text(binding.username.wrappedValue).bold()
                .font(.system(size: 24))
                .foregroundColor(Color(.label))
                
                
            Spacer()
            
        }.frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        
        
    }
    
    
    
    var body: some View{
        VStack(spacing: 0){
            
            if binding.isLogin.wrappedValue{
                loggedInView
            }else{
                unloggedInView
            }
            
        }.padding([.horizontal, .top],30)
        .padding(.bottom, 20)
        .onTapGesture {
            if !binding.isLogin.wrappedValue{
                self.isLoginPresented.toggle()
            }
        }
        .sheet(isPresented: $isLoginPresented) {
            LoginView()
                .environmentObject(Store.shared)
        }
    }
}

private struct InfoCell: View{
    
    var title: String
    var imgName: String
    
    var body: some View{
        HStack(spacing: 10){
            Image(systemName: imgName)
            Text(title)
            
            Spacer()
            
            ArrowImg()
        }.frame(height: 54)
        .foregroundColor(Color(.label))
        .padding(.horizontal, 20)
        .contentShape(Rectangle())
    }
}
