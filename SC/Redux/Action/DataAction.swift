//
//  DataAction.swift
//  SC
//
//  Created by 沉寂 on 2021/3/23.
//

import Foundation
import LeanCloud



extension Store{
    
    
    func loadPosts(){
        
        self.showHud()
        
        let query = LCQuery(className: "Post")
        try? query.where("createdAt", .descending)
        query.limit = 100
        
        query.find { (res) in
            
            self.hideHud()
            
            switch res{
            case let .success(objs):
                self.appState.post.array = objs
            case let .failure(error):
                self.appState.post.error = .normal(error)
            }
        }
        
    }
    
    
    
}
