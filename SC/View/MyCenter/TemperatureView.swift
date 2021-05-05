//
//  TemperatureView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI

struct TemperatureView: View {
    
    @State var address = ""
    
    var body: some View {
        
        VStack(spacing: 10){
            
            HStack(spacing: 10){
                Text("调温房间")
                TextField("请输入调温房间", text: $address)
                    .padding(.horizontal, 10)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
            }.frame(height: 54)
            
            HStack(spacing: 10){
                Text("调温时段")
                Button(action: {
                    
                }) {
                    Text("请选择调温时段")
                        .padding(.horizontal, 10)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
            }.frame(height: 54)
            
            MButton(text: "提交申请") {
                
            }
            
            Spacer()
            
        }.padding(.horizontal, 20)
        .font(.system(size: 14))
        .navigationBarTitle("调温", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Text("申请记录")
                .bold()
                .font(.system(size: 14))
        })
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TemperatureView()
        }
    }
}
