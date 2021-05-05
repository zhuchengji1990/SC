//
//  ScheduleView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI

struct CourseView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Post>{
        $store.appState.post
    }
    
    @State var selection = 0
    
    var body: some View {
        VStack(spacing: 0){
            
            Picker("", selection: $selection) {
                Text("单周").tag(0)
                Text("双周").tag(1)
                Text("全部").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(10)
            
            Spacer()
            
            //            PostView(array: binding.array.wrappedValue
            //                        .filter{ $0.get("type")?.stringValue == Store.PublishType.schedule.rawValue })
        }.navigationBarTitle("课表", displayMode: .inline)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CourseView().environmentObject(Store.shared)
        }
    }
}
