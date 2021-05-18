//
//  UserView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/18.
//

import SwiftUI
import LeanCloud

struct UserView: View {
    @Environment(\.presentationMode) private var presentationMode
    var array: [LCObject]
    var action: (LCObject) -> Void
    var body: some View {
        NavigationView{
            List{
                ForEach(array, id: \.self) { obj in
                    HStack{
                        Text(obj.get("name")?.stringValue ?? "用户")
                        Spacer()
                    }.frame(height: 44)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                        action(obj)
                    }
                }
            }
            .navigationBarTitle("选择用户", displayMode: .inline)
            .navigationBarItems(leading: CloseBtn{
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
