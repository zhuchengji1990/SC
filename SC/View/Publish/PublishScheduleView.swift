//
//  PublishScheduleView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/23.
//

import SwiftUI
import LeanCloud

struct PublishScheduleView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.PublishSchedule>{
        $store.appState.publishSchedule
    }
    
    var hud: Binding<AppState.Hud>{
        $store.appState.hud
    }
    
    @State var isPresented = false
    
    init(){
        UITextView.appearance().backgroundColor = .clear
    }
    
    @State var courseArray: [LCObject] = []
    
    @State var isShowDatePicker = false
    @State var isShowCoursePicker = false
    @State var startDate = Date()
    
    @State var isFirst = true
    
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                
                HStack{
                    Text("有什么任务要计划的：").font(.system(size: 14))
                    Spacer()
                }
                
                TextEditor(text: binding.text)
                    .frame(height: 100)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                HStack(spacing: 10){
                    Text("开始时间")
                    Button(action: {
                        self.isShowDatePicker = true
                    }) {
                        Group{
                            if let startDate = binding.startDate.wrappedValue{
                                Text(startDate.toString("yyyy-MM-dd HH:mm"))
                                    .foregroundColor(Color(.label))
                            }else{
                                Text("请选择时间")
                            }
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                }.frame(height: 54)
                
                HStack(spacing: 10){
                    Text("所属课程")
                    Button(action: {
                        self.isShowCoursePicker.toggle()
                    }) {
                        Group{
                            if let course = binding.course.wrappedValue{
                                Text(course.get("courseName")?.stringValue ?? "")
                                    .foregroundColor(Color(.label))
                            }else{
                                Text("请选择所属课程")
                            }
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                }.frame(height: 54)
                .sheet(isPresented: $isShowCoursePicker, content: {
                    CourseListView(array: courseArray) { obj in
                        binding.course.wrappedValue = obj
                    }
                })
                
                
                MButton(text: "发布", disabled: binding.isNextDisabled) {
                    Store.shared.showHud()
                    let obj = LCObject(className: "Schedule")
                    try? obj.set("owner", value: LCApplication.default.currentUser)
                    try? obj.set("coursePointer", value: binding.course.wrappedValue)
                    try? obj.set("content", value: binding.text.wrappedValue)
                    try? obj.set("startDate", value: binding.startDate.wrappedValue)
                    obj.save { res in
                        Store.shared.hideHud()
                        switch res{
                        case .success:
                            self.presentationMode.wrappedValue.dismiss()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                Store.shared.appState.publishSchedule = AppState.PublishSchedule()
                                Store.shared.loadScheduleList()
                            }
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
                
                Spacer()
                
            }.padding(20)
            .alert(item: binding.error) { (error) -> Alert in
                Alert(title: Text("提示"), message: Text(error.localizedDescription))
            }
            .onReceive(binding.isSuccess.wrappedValue) { (_) in
                self.presentationMode.wrappedValue.dismiss()
            }
            .navigationBarTitle("发布待办事项", displayMode: .inline)
            .navigationBarItems(leading: CloseBtn{
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .overlay(Group{
            if isShowDatePicker{
                timePickerView
            }else{
                EmptyView()
            }
        })
        .onAppear{
            if isFirst{
                isFirst = false
                Store.shared.loadCourse { array in
                    self.courseArray = array
                }
                
            }
        }
        
    }
    
    var timePickerView: some View{
        OverlayView(title: "选择时间",
                    cancelAction: {
                        isShowDatePicker = false
                    }, okAction: {
                        binding.startDate.wrappedValue = startDate
                        isShowDatePicker = false
                    }){
            DatePicker("", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .environment(\.locale, Locale(identifier: "zh_Hans_CN"))
        }
    }
}

struct PublishScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        PublishScheduleView()
    }
}



private struct CourseListView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var array: [LCObject]
    var action: (LCObject) -> Void
    var body: some View{
        NavigationView{
            List{
                ForEach(array, id: \.self) { obj in
                    CourseCellView(obj: obj)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                            action(obj)
                        }
                }
            }.listStyle(PlainListStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("选择课程", displayMode: .inline)
            .navigationBarItems(leading: CloseBtn{
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}



private struct CourseCellView: View{
    var obj: LCObject
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(obj.get("courseName")?.stringValue ?? "").bold()
                .font(.system(size: 18))
                .foregroundColor(Color(.label))
            HStack{
                Text("@" + (obj.get("address")?.stringValue ?? ""))
                Text(obj.get("teacherName")?.stringValue ?? "")
                Spacer()
            }
            HStack{
                Text(obj.get("note")?.stringValue ?? "")
                
                Spacer()
            }
        }.font(.system(size: 14))
        .foregroundColor(Color(.secondaryLabel))
        .contentShape(Rectangle())
    }
}
