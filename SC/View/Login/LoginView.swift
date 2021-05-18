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
            VStack(spacing: 0){
                
                Picker(selection: binding.selection, label: Text("")) {
                    Text("登录").tag(0)
                    Text("注册").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .frame(width: 150)
                .padding(10)
                
                if binding.selection.wrappedValue == 0{
                    SignInView()
                }else{
                    SignUpView()
                }
                
                Spacer()
            }
            .alert(item: binding.error) { (error) -> Alert in
                Alert(title: Text("提示"), message: Text(error.localizedDescription))
            }
            .onReceive(binding.isSuccess.wrappedValue) { (_) in
                self.presentationMode.wrappedValue.dismiss()
            }
            .navigationBarTitle(binding.selection.wrappedValue == 0 ? "登录" : "注册", displayMode: .inline)
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
