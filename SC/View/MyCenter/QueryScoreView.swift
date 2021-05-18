//
//  QueryScoreView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI
import LeanCloud

struct QueryScoreView: View {
    
    @State var array: [LCObject] = []
    
    var body: some View {
        VStack{
            if array.count > 0{
                List{
                    ForEach(array, id: \.self) { obj in
                        HStack{
                            Text(getCourseName(obj))
                            Spacer()
                            Text(String(obj.get("score")?.intValue ?? 0))
                                .bold()
                        }.frame(height: 44)
                    }
                }
            }else{
                Text("无数据")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle("成绩查询", displayMode: .inline)
        .onAppear{
            guard let user = LCApplication.default.currentUser else { return }
            let query = LCQuery(className: "Score")
            try? query.where("owner", .equalTo(user))
            try? query.where("coursePointer", .included)
            query.find { res in
                switch res{
                case let .success(array):
                    self.array = array
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func getCourseName(_ obj: LCObject) -> String{
        let course = obj.get("coursePointer") as? LCObject
        return course?.get("courseName")?.stringValue ?? ""
    }
    
}

struct QueryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            QueryScoreView()
        }
    }
}
