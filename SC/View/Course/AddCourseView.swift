//
//  AddCourseView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/5.
//

import SwiftUI

struct AddCourseView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.AddCourse>{
        $store.appState.addCourse
    }
    
    var hud: Binding<AppState.Hud>{
        $store.appState.hud
    }
    
    @State var isPresented = false
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 10){
                    
                    InfoCell(title: "课程名称", text: binding.courseName)
                    InfoCell(title: "课程教师", text: binding.teacherName)
                    InfoCell(title: "教师电话", text: binding.phone)
//                    InfoCell(title: "课程类型", text: binding.type)
                    
                    
                    
                    
                    ColorCell(title: "颜色标记", color: binding.color)
                    
                    
                    MButton(text: "添加") {
                        self.presentationMode.wrappedValue.dismiss()
                        Store.shared.addCourse()
                    }.padding(.horizontal, 20)
                    
                    
                }.padding(.vertical, 10)
                .font(.system(size: 14))
            }
            .alert(item: binding.error) { error in
                Alert(title: Text("提示"), message: Text(error.localizedDescription))
            }
            .onReceive(binding.isSuccess.wrappedValue) { (_) in
                self.presentationMode.wrappedValue.dismiss()
            }
            .navigationBarTitle("添加课程", displayMode: .inline)
            .navigationBarItems(leading: CloseBtn{
                self.presentationMode.wrappedValue.dismiss()
            })
        }.loading(isShowing: hud.isShowing)
        
    }

}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseView().environmentObject(Store.shared)
    }
}


private struct InfoCell: View{
    var title: String
    @Binding var text: String
    var body: some View{
        HStack{
            Text(title)
            TextField("", text: _text)
                .padding(.horizontal, 10)
                .frame(height: 44)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
        }
        .padding(.horizontal, 20)
    }
}


private struct ColorCell: View{
    var title: String
    @Binding var color: MColor
    
    
    @State var isShowPicker = false
    
    var body: some View{
        HStack{
            Text(title)
            Button(action: {
                self.isShowPicker.toggle()
            }, label: {
                Text(color.name)
                    .foregroundColor(color.color)
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            })
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $isShowPicker, content: {
            MColorPicker{ res in
                color = res
            }
        })
    }
}



//
//
//private struct TypeCell: View{
//    var title: String
//    @Binding var type: Int
//
//
//
//    @State var isShowPicker = false
//
//    var body: some View{
//        HStack{
//            Text(title)
//            Button(action: {
//                self.isShowPicker.toggle()
//            }, label: {
//                Text(color.name)
//                    .foregroundColor(color.color)
//                    .padding(.horizontal, 10)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 44)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(10)
//            })
//        }
//        .padding(.horizontal, 20)
//        .sheet(isPresented: $isShowPicker, content: {
//            Picker(selection: $type, label: Text(""), content: {
//                Text("上午 1、2节").tag(1)
//                Text("上午 3、4节").tag(2)
//                Text("下午 5、6节").tag(3)
//                Text("下午 7、8节").tag(4)
//            }).pickerStyle(WheelPickerStyle())
//        })
//    }
//}
