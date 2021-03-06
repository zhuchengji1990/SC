//
//  ConfessionView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI
import LeanCloud

struct ConfessionView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Post>{
        $store.appState.post
    }
    
    var body: some View {
        
        PostView(array: binding.array.wrappedValue
                    .filter{ $0.get("type")?.stringValue == Store.PublishType.confession.rawValue })
        .navigationBarTitle("表白墙", displayMode: .inline)
    }
}

struct ConfessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionView().environmentObject(Store.shared)
    }
}

