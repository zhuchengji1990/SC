//
//  TodoListView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI

struct TodoListView: View {
    
    
    @State var selection = 0
    
    var body: some View {
        VStack{
            
            Picker(selection: $selection, label: Text("Picker")){
                Text("未完成").tag(0)
                Text("已完成").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            .frame(width: 200)
            .frame(height: 44)
            
            List{
                
                ForEach(0..<30) { index in
                    Text("待办事项\(index)")
                        .frame(height: 44)
                }
            }.listStyle(PlainListStyle())
            
        }.navigationBarTitle("待办事项", displayMode: .inline)
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
