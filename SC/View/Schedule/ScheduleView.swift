//
//  ScheduleView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI

struct ScheduleView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Post>{
        $store.appState.post
    }
    
    var body: some View {
        
        PostView(array: binding.array.wrappedValue
                    .filter{ $0.get("type")?.stringValue == Store.PublishType.schedule.rawValue })
            .navigationBarTitle("待办事项", displayMode: .inline)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView().environmentObject(Store.shared)
    }
}
