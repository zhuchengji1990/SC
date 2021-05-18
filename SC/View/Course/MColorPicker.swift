//
//  MColorPicker.swift
//  SC
//
//  Created by 沉寂 on 2021/5/16.
//

import SwiftUI


struct MColor: Hashable {
    var name:String
    var color: Color
    var tag: Int
    
    init(_ name: String, _ color: Color, tag: Int) {
        self.name = name
        self.color = color
        self.tag = tag
    }
}

let mColorArray: [MColor] = [
    .init("红色", Color(.systemRed), tag: 0),
    .init("橙色", Color(.systemOrange), tag: 1),
    .init("黄色", Color(.systemYellow), tag: 2),
    .init("绿色", Color(.systemGreen), tag: 3),
    .init("青色", Color(.systemTeal), tag: 4),
    .init("蓝色", Color(.systemBlue), tag: 5),
    .init("紫色", Color(.systemPurple), tag: 6)
]



struct MColorPicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var selection: Int = 0
    
    var completion: (MColor) -> Void
    var body: some View {
        NavigationView{
            VStack{
                Picker(selection: $selection, label: Text("Picker")) {
                    ForEach(mColorArray, id: \.self) { obj in
                        Text(obj.name)
                            .tag(obj.tag)
                    }
                }.pickerStyle(WheelPickerStyle())
                
                Spacer()
            }
            .navigationBarTitle("颜色选择器", displayMode: .inline)
            .navigationBarItems(leading: CloseBtn{
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                completion(mColorArray[selection])
            }, label: {
                Text("确定")
                    .padding(5)
            }))
        }
    }
}

struct MColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        MColorPicker{_ in}
    }
}
