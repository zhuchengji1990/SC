//
//  SignInView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/18.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.SignIn>{
        $store.appState.signIn
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
            
            
            MButton(text: "登录", disabled: binding.isNextDisabled) {
                Store.shared.login()
            }
        }.padding(20)
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(Store.shared)
    }
}
