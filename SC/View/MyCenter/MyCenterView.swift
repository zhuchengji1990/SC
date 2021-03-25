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
            VStack(spacing: 10){
                
                InfoView()
                
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
                }.padding(.horizontal, 20)
                
                HStack{
                    
                    TypeCell(title: "待办事项", imgName: "bell", color: Color(.systemTeal))
                    Spacer()
                    TypeCell(title: "请假", imgName: "bell", color: Color(.systemPurple))
                    Spacer()
                    TypeCell(title: "表白", imgName: "bell", color: Color(.systemBlue))
                    Spacer()
                    TypeCell(title: "报修", imgName: "bell", color: Color(.systemIndigo))
                    
                }.padding(.horizontal, 20)
                
                
                
                InfoCell(title: "设置", imgName: "gear")
                if binding.isLogin.wrappedValue{
                    InfoCell(title: "退出登录", imgName: "xmark.circle")
                        .onTapGesture {
                            Store.shared.logout()
                        }
                }
                
            }
            
        }.listStyle(PlainListStyle())
        
        .navigationBarTitle("我的", displayMode: .inline)
        
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
        HStack{
            Image(systemName: imgName)
            Text(title)
            
            Spacer()
        }.frame(height: 54)
        .padding(.horizontal, 15)
        .contentShape(Rectangle())
        
        
    }
}
