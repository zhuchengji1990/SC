//
//  AnnouncementView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/24.
//

import SwiftUI

struct AnnouncementView: View {
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Post>{
        $store.appState.post
    }
    var body: some View {
        PostView(array: binding.array.wrappedValue
                    .filter{ $0.get("type")?.stringValue == Store.PublishType.announcement.rawValue })
            .navigationBarTitle("学校公告", displayMode: .inline)
    }
}

struct AnnouncementView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementView().environmentObject(Store.shared)
    }
}
