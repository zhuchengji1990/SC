//
//  SettingView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI
import LeanCloud

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            Spacer()
            
            if let _ = LCApplication.default.currentUser{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    Store.shared.logout()
                }, label: {
                    Text("退出登录")
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray4))
                        .cornerRadius(22)
                        .padding(20)
                        .foregroundColor(Color.black)
                })
            }
        }
        .navigationBarTitle("设置", displayMode: .inline)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
