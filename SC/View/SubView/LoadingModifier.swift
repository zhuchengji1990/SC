//
//  LoadingModifier.swift
//  SleepCare
//
//  Created by 沉寂 on 2020/12/7.
//

import SwiftUI

//调用方式一：Text("").modifier(LoadingModifier(isShowing: self.$store.appState.hud.isShowing))
//支持任意视图
struct LoadingModifier: ViewModifier{
    @Binding var isShowing: Bool
    @Binding var title: String
    func body(content: Content) -> some View{
        GeometryReader { geo in
            ZStack{
                content.disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 5 : 0)
                
                ZStack{
                    Color(.black).opacity(0.5)
                    
                    VStack(spacing: 15) {
                        
                        ProgressView()
                        
                        Text(self.title).bold()
                            .font(.system(size: 15))
                            .foregroundColor(Color(.black).opacity(0.6))
                    }.frame(width: geo.size.width / 3, height: geo.size.width / 3)
                    .background(Color(.white).opacity(0.5))
                    .cornerRadius(16)
                }.opacity(self.isShowing ? 1 : 0)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


//调用方式二：Text("").loading(isShowing: self.$store.appState.hud.isShowing)
//支持任意视图
extension View{
    func loading(isShowing: Binding<Bool>, title: Binding<String> = .constant("Loading")) -> some View{
        self.modifier(LoadingModifier(isShowing: isShowing, title: title))
    }
}

