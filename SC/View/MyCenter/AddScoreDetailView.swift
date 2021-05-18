//
//  AddScoreDetail.swift
//  SC
//
//  Created by 沉寂 on 2021/5/18.
//

import SwiftUI
import LeanCloud

struct AddScoreDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var course: LCObject
    var user: LCObject
    
    @State private var obj: LCObject?
    
    @State var score = "0"
    
    var body: some View {
        
        VStack(spacing: 20){
            HStack{
                
                Text("学生：")
                
                Text(user.get("name")?.stringValue ?? "").bold()
                Spacer()
            }
            .font(.system(size: 16))
            HStack{
                
                Text("课程：")
                
                Text(course.get("courseName")?.stringValue ?? "").bold()
                Spacer()
            }
            .font(.system(size: 16))
            
            TextField("请输入成绩", text: $score)
                .keyboardType(.numberPad)
                .padding(.horizontal, 10)
                .frame(height: 44)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            Spacer()
            
        }.padding(20)
        .navigationBarTitle("录入成绩", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            if let value = Int(score),
               value >= 0{
                saveScore(value)
            }
        }) {
            Text("保存")
                .padding()
        })
        .onAppear{
            let query = LCQuery(className: "Score")
            try? query.where("coursePointer", .equalTo(course))
            try? query.where("owner", .equalTo(user))
            query.getFirst { res in
                switch res{
                case let .success(obj):
                    self.obj = obj
                    self.score = String(obj.get("score")?.intValue ?? 0)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    
    func saveScore(_ value: Int){
        Store.shared.showHud()
        if obj == nil{
            obj = LCObject(className: "Score")
        }
        
        try? obj?.set("coursePointer", value: course)
        try? obj?.set("owner", value: user)
        try? obj?.set("score", value: value)
        obj?.save { res in
            Store.shared.hideHud()
            switch res{
            case .success:
                self.presentationMode.wrappedValue.dismiss()
            case let .failure(error):
                print(error)
            }
            
        }
    }
    
    
}

struct AddScoreDetail_Previews: PreviewProvider {
    static var previews: some View {
        AddScoreDetailView(course: LCObject(), user: LCObject())
    }
}
