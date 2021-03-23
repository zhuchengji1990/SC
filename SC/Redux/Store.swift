//
//  Store.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import Foundation
import Combine

class Store: ObservableObject{
    
    static let shared = Store()
    private init() {}
    
    @Published var appState = AppState()
    
    var bags = Set<AnyCancellable>()
    
    
    
    
}

extension Store{
    
    
    func run(){
        
        initLeanCloud()
        
        loadUserInfo()
        
        loadAllData()
        
    }
}

extension Store{
    
    
    
    func showHud(_ title: String = "加载中"){
        DispatchQueue.main.async {
            self.appState.hud.show(title)
        }
    }
    
    func hideHud(){
        DispatchQueue.main.async {
            self.appState.hud.hide()
        }
    }
    
}

