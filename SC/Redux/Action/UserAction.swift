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
        
        let state = self.appState.signUp
        
        let username = state.username
        let password = state.password
        
        let user = LCUser()
        
        user.username = LCString(username)
        user.password = LCString(password)
        try? user.set("name", value: state.name)
        try? user.set("studentNumber", value: state.studentNumber)
        try? user.set("idNumber", value: state.idNumber)
        
        user.signUp { res in
            
            self.hideHud()
            
            LCApplication.default.currentUser = user
            
            self.loadUserInfo()
            
            switch res{
            case .success:
                
                self.appState.login.isSuccess.send(true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.appState.login = AppState.Login()
                    self.appState.signUp = AppState.SignUp()
                }
                
            case let .failure(error):
                print(error)
                self.appState.login.error = .signUp(error)
            }
        }
        
    }
    
    
    func login(){
        
        self.showHud()
        
        let state = self.appState.signIn
        
        let username = state.username
        let password = state.password
        
        LCUser.logIn(username: username, password: password){ (res) in
            
            self.hideHud()
            
            switch res{
            case let .success(user):
                print(user)
                
                self.appState.login.isSuccess.send(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.appState.login = AppState.Login()
                    self.appState.signIn = AppState.SignIn()
                }
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
            state.name = user.get("name")?.stringValue ?? "无名氏"
        }else{
            state.isLogin = false
            state.name = "点击登录"
        }
        self.appState.myCenter = state
    }
    
    func logout(){
        LCUser.logOut()
        
        loadUserInfo()
    }
    
    
    func loadAllData(){
        
        loadPosts()
        
        loadCourseList()
        loadScheduleList()
    }
    
    func loadUserList(completion: @escaping ([LCObject]) -> Void){
        self.showHud()
        let query = LCQuery(className: "_User")
        query.find { res in
            self.hideHud()
            switch res{
            case let .success(array):
                completion(array)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
}
