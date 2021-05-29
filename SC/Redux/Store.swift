//
//  Store.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import Foundation
import Combine
import UIKit
import LeanCloud

class Store: ObservableObject{
    
    static let shared = Store()
    private init() {}
    
    @Published var appState = AppState()
    
    @Published var isUnLogin = true
    
    
    enum Role: String{
        case student = "学生" //数据库role字段，0
        case teacher = "教师" //数据库role字段，1
        case admin = "管理员" //数据库role字段，2
    }
    
    @Published var role: Role = .student
    
    var user: LCUser?{
        LCApplication.default.currentUser
    }
    
    
    var bags = Set<AnyCancellable>()
    
}

extension Store{
    
    func run(){
        
        UITextView.appearance().backgroundColor = .clear
        
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


