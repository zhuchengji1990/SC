//
//  OverlayView.swift
//  SleepCare
//
//  Created by 沉寂 on 2020/12/7.
//

import SwiftUI

struct OverlayView<Content: View>: View {
    var title: String
    var cancelAction: () -> Void
    var okAction: () -> Void
    var content: () -> Content
    var body: some View {
        VStack(spacing: 0){
            Spacer()
            VStack(spacing: 0){
                HStack(spacing: 0){
                    Button(action: {
                        withAnimation(.easeOut) {
                            cancelAction()
                        }
                    }){
                        Text("取消").bold()
                            .frame(height: 44)
                            .padding(.horizontal, 15)
                    }
                    
                    Spacer()
                    
                    Text(title).bold()
                        .font(.system(size: 18))
                        .foregroundColor(Color(.label))
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            okAction()
                        }
                    }){
                        Text("确定").bold()
                            .frame(height: 44)
                            .padding(.horizontal, 15)
                    }
                    
                }.foregroundColor(Color(.label))
                
                Divider()
                
                Spacer()
                
                content()
                
                Spacer()
            }.frame(height: 300)
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
        }.background(Color(.label).opacity(0.4).edgesIgnoringSafeArea(.all))
        
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView(title: "选择时间", cancelAction: {}, okAction: {}, content: {
            Text("")
        })
    }
}
