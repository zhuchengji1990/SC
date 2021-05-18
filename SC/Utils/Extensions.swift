//
//  Extensions.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//


import Foundation
import SwiftUI
import UIKit
import LeanCloud
import SwiftyJSON
import Combine


extension Color{
    static let theme = Color(.systemBlue)
}

extension Spacer {
    public func onTapEndEditing() -> some View {
        ZStack {
            Color(.systemBackground).onTapGesture(count: 1){
                UIApplication.shared
                    .sendAction(#selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil)
            }
            self
        }
    }
}

extension View{
    public func onTapEndEditing() -> some View {
        ZStack {
            Color(.systemBackground).opacity(0.01).onTapGesture(count: 1){
                UIApplication.shared
                    .sendAction(#selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil)
            }
            self
        }
    }
    
    public func endEditing(){
        UIApplication.shared
            .sendAction(#selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil)
    }
    
}

extension Data {
    func toIntArray() -> [Int]{
        return self.map{ Int($0) }
    }
    
}



extension LCEngine{
    
    public static func runPublisher(
        _ function: String,
        params: [String: Any]? = nil,
        completionQueue: DispatchQueue = .main
    ) -> AnyPublisher<Result<JSON, Error>, Never> {
        Future{ promise in
            LCEngine.run(
                function,
                parameters: params,
                completionQueue: completionQueue
            ){ res in
                switch res{
                case let .success(value):
                    promise(.success(.success(JSON(value))))
                case let .failure(error):
                    promise(.success(.failure(error)))
                }
            }
        }.receive(on: completionQueue)
        .eraseToAnyPublisher()
    }
}

extension LCUser{
    
    public func saveUserPublisher(completionQueue: DispatchQueue = .main) -> AnyPublisher<Result<LCUser, Error>, Never> {
        Future{ promise in
            self.save(completionQueue: completionQueue){ res in
                switch res{
                case .success:
                    promise(.success(.success(self)))
                case let .failure(error):
                    promise(.success(.failure(error)))
                }
            }
        }.receive(on: completionQueue)
        .eraseToAnyPublisher()
    }
}

extension LCObject{
    
    public func savePublisher(completionQueue: DispatchQueue = .main) -> AnyPublisher<Result<LCObject, Error>, Never> {
        Future{ promise in
            self.save(completionQueue: completionQueue){ res in
                switch res{
                case .success:
                    promise(.success(.success(self)))
                case let .failure(error):
                    promise(.success(.failure(error)))
                }
            }
        }.receive(on: completionQueue)
        .eraseToAnyPublisher()
    }
}


extension LCFile{
    
    public func uploadPublisher(completionQueue: DispatchQueue = .main) -> AnyPublisher<Result<LCFile, Error>, Never> {
        Future{ promise in
            self.save(completionQueue: completionQueue){ res in
                switch res{
                case .success:
                    promise(.success(.success(self)))
                case let .failure(error):
                    promise(.success(.failure(error)))
                }
            }
        }.receive(on: completionQueue)
        .eraseToAnyPublisher()
    }
}


extension String{
    
    var localizedString: LocalizedStringKey{
        LocalizedStringKey(self)
    }
    
}

extension Date{
    func toString(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String{
        let f = DateFormatter()
        f.dateFormat = dateFormat
        f.locale = .current
        return f.string(from: self)
    }
    
    func toCNString(_ dateFormat: String = "yyyy年MM月dd日") -> String{
        let f = DateFormatter()
        f.dateFormat = dateFormat
        f.locale = .current
        return f.string(from: self)
    }
}


var numberFormatter: NumberFormatter{
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    return formatter
}


extension Double{
    func toString() -> String{
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

extension Int{
    func toString() -> String{
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

extension Color {
    static let background = Color(.systemBackground)//Color(.systemGray5)
}

extension UIColor {
    static let background = UIColor.systemBackground//UIColor.systemGray5
}

extension View{
    func mShadow() -> some View{
        self.shadow(color: Color(.label).opacity(0.1), radius: 5, x: 3, y: 3)
    }
    
    func hideListDivider(_ background: Color = Color(.systemBackground), cellHeight: CGFloat = .infinity) -> some View{
        Group{
            if #available(iOS 14, *){
                self.frame(maxWidth: .infinity, maxHeight: cellHeight, alignment: .leading)
                    .background(background)
                    .listRowInsets(EdgeInsets())
            }else{
                self
            }
        }
    }
    
    
}


class CombineToken {
    var object: AnyCancellable?
    func unlock() {
        object = nil
    }
}

extension AnyCancellable {
    func lock(in token: CombineToken) {
        token.object = self
    }
}

extension LCObject: Identifiable{
    public var id: String { self.objectId?.stringValue ?? UUID().uuidString }
}



extension Int{
    var courseStr: String{
        switch self {
        case 1: return "上午 第1、2节"
        case 2: return "上午 第3、4节"
        case 3: return "下午 第5、6节"
        default: return "下午 第7、8节"
        }
    }
    
    var weekStr: String{
        switch self {
        case 1: return "周一"
        case 2: return "周二"
        case 3: return "周三"
        case 4: return "周四"
        case 5: return "周五"
        case 6: return "周六"
        default: return "周日"
        }
    }
}
