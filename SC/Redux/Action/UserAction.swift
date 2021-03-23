//
//  UserAction.swift
//  SC
//
//  Created by 沉寂 on 2021/3/23.
//

import Foundation
import LeanCloud


extension Store{
    
    func initLeanCloud(){
        
        do {
            LCApplication.logLevel = .debug
            try LCApplication.default.set(
                id: "yDEqUvxxxkTiPbXz080n7ajt-9Nh9j0Va",
                key: "wmpwr3oxMvaBHh5F1dvOSu4Q",
                serverURL: "https://ydequvxx.lc-cn-e1-shared.com")
        } catch {
            print(error)
        }
        
    }
    
    
    func signUp(){
        
        self.showHud()
        
        var state = self.appState.login
        
        let username = state.username
        let password = state.password
        
        let user = LCUser()
        
        user.username = LCString(username)
        user.password = LCString(password)
        
        user.signUp { (res) in
            
            self.hideHud()
            
            switch res{
            case .success:
                state.username = ""
                state.password = ""
                state.isNextDisabled = true
                self.appState.login = state
                self.appState.login.isSuccess.send(true)
            case let .failure(error):
                print(error)
                self.appState.login.error = .signUp(error)
            }
            
            self.loadUserInfo()
        }
        
    }
    
    
    func login(){
        
        self.showHud()
        
        var state = self.appState.login
        
        let username = state.username
        let password = state.password
        
        LCUser.logIn(username: username, password: password){ (res) in
            
            self.hideHud()
            
            switch res{
            case let .success(user):
                print(user)
                state.username = ""
                state.password = ""
                self.appState.login = state
                self.appState.login.isSuccess.send(true)
            case let .failure(error):
                print(error)
                self.appState.login.error = .login(error)
            }
            
            self.loadUserInfo()
        }
        
    }
    
    
    func loadUserInfo(){
        var state = self.appState.myCenter
        if let user = LCApplication.default.currentUser{
            state.isLogin = true
            state.username = user.username?.stringValue ?? "无名氏"
        }else{
            state.isLogin = false
            state.username = "点击登录"
        }
        self.appState.myCenter = state
    }
    
    func logout(){
        LCUser.logOut()
        
        loadUserInfo()
    }
    
    
    func loadAllData(){
        
        loadPosts()
        
        
    }
}
