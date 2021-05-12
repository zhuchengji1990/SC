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
        case announcement
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
                    
                    self.loadPosts()
                    
                case let .failure(error):
                    self.appState.publish.error = .publishConfession(error)
                }
            }.store(in: &bags)
    }
    
    
    func sendRepair(){
        
        guard let user = LCApplication.default.currentUser else { return }
        
        let state = self.appState.repair
        let address = state.address.trimmingCharacters(in: .whitespacesAndNewlines)
        let text = state.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if address.count == 0 || text.count == 0{
            return
        }
        
        self.showHud()
        
        if let image = state.image,
           let data = image.jpegData(compressionQuality: 1.0){
            
            let imgFile = LCFile(payload: .data(data: data))
            imgFile.name = LCString("pic.jpg")
            imgFile.uploadPublisher()
                .flatMap { res -> AnyPublisher<Result<LCObject, Error>, Never> in
                    
                    let obj = LCObject(className: "Repair")
                    try? obj.set("owner", value: user)
                    try? obj.set("text", value: text)
                    try? obj.set("address", value: address)
                    
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
                        self.appState.repair.isSuccess.send(true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.appState.repair = AppState.Repair()
                        }
                    case let .failure(error):
                        self.appState.repair.error = .normal(error)
                    }
                }.store(in: &bags)
            
        }else{
            let obj = LCObject(className: "Repair")
            try? obj.set("owner", value: user)
            try? obj.set("text", value: text)
            try? obj.set("address", value: address)
            obj.savePublisher()
                .sink { res in
                    self.hideHud()
                    
                    switch res{
                    case .success:
                        self.appState.repair.isSuccess.send(true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.appState.repair = AppState.Repair()
                        }
                    case let .failure(error):
                        self.appState.repair.error = .normal(error)
                    }
                }.store(in: &bags)
        }
    }
    
    func sendLeave(){
        
        let state = self.appState.leave
        
        guard let startDate = state.startDate,
              let endDate = state.endDate else {
            return
        }
        self.showHud()
        let obj = LCObject(className: "Leave")
        try? obj.set("owner", value: self.user)
        try? obj.set("startDate", value: startDate)
        try? obj.set("endDate", value: endDate)
        try? obj.set("text", value: state.text)
        obj.savePublisher()
            .sink { res in
                self.hideHud()
                
                switch res{
                case .success:
                    self.appState.leave.isSuccess.send(true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.appState.leave = AppState.Leave()
                    }
                case let .failure(error):
                    self.appState.leave.error = .normal(error)
                }
            }.store(in: &bags)
    }
    
    func sendTemperature(){
        
        let state = self.appState.temperature
        
        guard let startDate = state.startDate,
              let endDate = state.endDate else {
            return
        }
        self.showHud()
        let obj = LCObject(className: "Temperature")
        try? obj.set("owner", value: self.user)
        try? obj.set("startDate", value: startDate)
        try? obj.set("endDate", value: endDate)
        try? obj.set("text", value: state.text)
        obj.savePublisher()
            .sink { res in
                self.hideHud()
                
                switch res{
                case .success:
                    self.appState.temperature.isSuccess.send(true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.appState.temperature = AppState.Temperature()
                    }
                case let .failure(error):
                    self.appState.temperature.error = .normal(error)
                }
            }.store(in: &bags)
    }
    
    
    
}
