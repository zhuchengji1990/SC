//
//  SCApp.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI

@main
struct SCApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Store.shared)
                .onAppear{
                    Store.shared.run()
                }
        }
    }
}
