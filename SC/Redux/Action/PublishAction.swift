//
//  PublishAction.swift
//  SC
//
//  Created by 沉寂 on 2021/3/23.
//

import Foundation
import LeanCloud
import Combine

extension Store{
    
    enum PublishType: String{
        case confession
        case schedule
    }
    
    
    func publish(type: PublishType){
        
        guard let user = LCApplication.default.currentUser else { return }
        
        self.showHud()
        
        var state = self.appState.publish
        
        let text = state.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let image = state.image,
              text.count > 0,
              let data = image.jpegData(compressionQuality: 1.0) else {
            self.hideHud()
            return
        }
        
        let imgFile = LCFile(payload: .data(data: data))
        imgFile.name = LCString("\(type.rawValue).jpg")
        imgFile.uploadPublisher()
            .flatMap { res -> AnyPublisher<Result<LCObject, Error>, Never> in
                
                let obj = LCObject(className: "Post")
                try? obj.set("owner", value: user)
                try? obj.set("text", value: text)
                try? obj.set("type", value: type.rawValue)
                
                switch res{
                case let .success(file):
                    try? obj.set("pic", value: file)
                case let .failure(error):
                    print(error)
                }
                return obj.savePublisher()
            }.sink { res in
                self.hideHud()
                
                switch res{
                case .success:
                    state.image = nil
                    state.text = ""
                    state.isNextDisabled = true
                    
                    self.appState.publish = state
                    self.appState.publish.isSuccess.send(true)
                    
                    //重新加载表白墙
                    self.loadPosts()
                    
                case let .failure(error):
                    self.appState.publish.error = .publishConfession(error)
                }
            }.store(in: &bags)
    }
    
    
}
