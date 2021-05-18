//
//  SignUpView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/18.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.SignUp>{
        $store.appState.signUp
    }
    
    var hud: Binding<AppState.Hud>{
        $store.appState.hud
    }
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Image(systemName: "person")
                TextField("请输入用户名", text: binding.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            
            HStack{
                Image(systemName: "lock")
                SecureField("请输入至少6位密码", text: binding.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            
            HStack{
                Image(systemName: "person.crop.square")
                TextField("请输入真实姓名", text: binding.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            
            HStack{
                Image(systemName: "number.circle")
                TextField("请输入10位学号", text: binding.studentNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            HStack{
                Image(systemName: "greetingcard")
                TextField("请输入身份证号", text: binding.idNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            
            MButton(text: "注册", disabled: binding.isNextDisabled) {
                Store.shared.signUp()
            }
            
        }.padding(20)
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(Store.shared)
    }
}
