//
//  AppState.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import Foundation
import Combine
import UIKit
import LeanCloud

struct AppState {
    
    var hud = Hud()
    var main = Main()
    var home = Home()
    
    var post = Post()
    
    var myCenter = MyCenter()
    var login = Login()
    
    
    var publish = Publish()
    
}


extension AppState{
    
    
    struct Hud {
        var isShowing = false
        var title = ""
        
        mutating func show(_ title: String = "加载中"){
            self.title = title
            self.isShowing = true
        }
        
        mutating func hide(){
            self.isShowing = false
        }
    }
    
    struct Main {
        var selection = 0
    }
    
    struct Home {
        
    }
    
    
    struct Post {
        var array: [LCObject] = []
        
        var error: AppError?
    }
    
    struct MyCenter {
        var isLogin = false
        var username = "点击登录"
    }
    
    struct Login{
        var username = ""{
            didSet{
                isNextDisabled = username.count < 6 || password.count < 6
            }
        }
            
        var password = ""{
            didSet{
                isNextDisabled = username.count < 6 || password.count < 6
            }
        }
        
        var isNextDisabled = true
        
        var isSuccess = PassthroughSubject<Bool, Never>()
        var error: AppError?
    }
    
    struct Publish {
        var text = ""{
            didSet{
                isNextDisabled = text.count == 0 || image == nil
            }
        }
        
        var image: UIImage? = nil{
            didSet{
                isNextDisabled = text.count == 0 || image == nil
            }
        }
        
        var isNextDisabled = true
        
        var isSuccess = PassthroughSubject<Bool, Never>()
        var error: AppError?
    }
    
   
    
    
    
}
