//
//  AppError.swift
//  BookKeeping
//
//  Created by 沉寂 on 2020/12/7.
//

import Foundation
import SwiftUI

enum AppError: Error, Identifiable{
    var id: String{ localizedDescription }
    
    case signUp(_ error: Error)
    case login(_ error: Error)
    case publishConfession(_ error: Error)
    case publishSchedule(_ error: Error)
    
    
    
    case normal(_ error: Error)
    case unknown
}

extension AppError: LocalizedError{
   
    
    var localizedDescription: String{
        switch self {
        
        case let .signUp(error): return "注册失败：\(error)"
        case let .login(error): return "登录失败：\(error)"
        case let .publishConfession(error): return "发布表白墙失败：\(error)"
        case let .publishSchedule(error): return "发布课表失败：\(error)"
        
        
        case let .normal(error): return "\(error)"
        default: return "未知错误"
        }
    }
}


