//
//  HomeView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        List{
            ForEach(0..<20){ index in
                InfoCell(title: "待办事项\(index)")
            }
        }.listStyle(PlainListStyle())
        .navigationBarTitle("首页", displayMode: .inline)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct TypeCell: View{
    
    var title: String
    var imgName: String
    var color: Color
    var body: some View{
        VStack(spacing: 5){
            
            Image(systemName: imgName)
                .imageScale(.large)
                .frame(width: 54, height: 54)
                .background(color)
                .clipShape(Circle())
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
        }.frame(width: 80)
    }
    
    
}

private struct InfoCell: View {
    var title: String
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            
            ArrowImg()
        }.frame(height: 64)
    }
}
