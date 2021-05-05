//
//  LoginView.swift
//  BookKeeping
//
//  Created by 沉寂 on 2020/12/15.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Login>{
        $store.appState.login
    }
    
    var hud: Binding<AppState.Hud>{
        $store.appState.hud
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                HStack{
                    Image(systemName: "person")
                    TextField("请输入用户名", text: binding.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 44)
                }
                
                HStack{
                    Image(systemName: "lock")
                    SecureField("请输入密码", text: binding.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 44)
                }
                
                
                MButton(text: "登录", disabled: binding.isNextDisabled) {
                    Store.shared.login()
                }
                
                MButton(text: "注册", disabled: binding.isNextDisabled) {
                    Store.shared.signUp()
                }
                
                Spacer()
                
            }.padding(20)
            .alert(item: binding.error) { (error) -> Alert in
                Alert(title: Text("提示"), message: Text(error.localizedDescription))
            }
            .onReceive(binding.isSuccess.wrappedValue) { (_) in
                self.presentationMode.wrappedValue.dismiss()
            }
            .navigationBarTitle("登录", displayMode: .inline)
            .navigationBarItems(leading: CloseBtn{
                self.presentationMode.wrappedValue.dismiss()
            })
        }.loading(isShowing: hud.isShowing)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Store.shared)
    }
}
