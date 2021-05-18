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
import SwiftUI

struct AppState {
    
    var hud = Hud()
    var main = Main()
    var home = Home()
    var course = Course()
    
    var post = Post()
    
    var myCenter = MyCenter()
    var login = Login()
    
    var publish = Publish()
    var addCourse = AddCourse()
    var repair = Repair()
    var leave = Leave()
    var temperature = Temperature()
    var publishSchedule = PublishSchedule()
    
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
        var courseArray: [LCObject] = []
        var scheduleArray: [LCObject] = []
    }
    
    struct Course {
        var courseArray: [LCObject] = []
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
    
    
    
    
    struct AddCourse{
        var courseName = ""
        var teacherName = ""
        var phone = ""
        var address = ""
        
        var week: [Int] = []
        var weekday = 1
        var type = 1
        
        var startDate: Date?
        var endDate: Date?
        
        var color: MColor = mColorArray[0]
        
        var isSuccess = PassthroughSubject<Bool, Never>()
        var error: AppError?
    }
    
    
    struct Repair {
        var address = ""
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
    
    
    struct Leave {
        var startDate: Date?
        var endDate: Date?
        var text: String = ""
        
        var isNextDisabled = true
        
        var isSuccess = PassthroughSubject<Bool, Never>()
        var error: AppError?
    }
    
    struct Temperature {
        var startDate: Date?
        var endDate: Date?
        var text: String = ""
        
        var isNextDisabled = true
        
        var isSuccess = PassthroughSubject<Bool, Never>()
        var error: AppError?
    }
    
    
    struct PublishSchedule {
        var text: String = ""{
            didSet{
                isNextDisabled = text.count == 0 || startDate == nil || course == nil
            }
        }
        var startDate: Date?{
            didSet{
                isNextDisabled = text.count == 0 || startDate == nil || course == nil
            }
        }
        var course: LCObject?{
            didSet{
                isNextDisabled = text.count == 0 || startDate == nil || course == nil
            }
        }
        
        var isNextDisabled = true
        
        var isSuccess = PassthroughSubject<Bool, Never>()
        var error: AppError?
    }
    
}

