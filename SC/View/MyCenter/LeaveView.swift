//
//  LeaveView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI

struct LeaveView: View {
    
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack(spacing: 10){
                Text("请假时间")
                Button(action: {
                    
                }) {
                    Text("请选择请假时间")
                        .padding(.horizontal, 10)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
            }.frame(height: 54)
            
            HStack(spacing: 10){
                Text("请假理由")
                TextField("请输入请假理由", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
            }.frame(height: 54)
            
            MButton(text: "提交申请") {
                
            }
            
            Spacer().onTapEndEditing()
            
        }.padding(.horizontal, 20)
        .font(.system(size: 14))
        .navigationBarTitle("请假", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Text("申请记录")
                .bold()
                .font(.system(size: 14))
        })
    }
}

struct LeaveView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LeaveView()
        }
    }
}
