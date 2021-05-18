//
//  TodoListView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Home>{
        $store.appState.home
    }
    
    @State var selection = 0
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                
                ForEach(binding.scheduleArray.wrappedValue){ obj in
                    NavigationLink(destination: ScheduleDetailView(obj: obj)){
                        ScheduleCell(obj: obj)
                    }
                }
                
                Spacer()
            }.padding(20)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .navigationBarTitle("待办事项", displayMode: .inline)
        .onAppear{
            Store.shared.loadScheduleList()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
