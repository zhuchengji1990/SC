//
//  LeaveView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI

struct LeaveView: View {
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Leave>{
        $store.appState.leave
    }
    
    @State var isActive = false
    
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var isShowDatePicker1 = false
    @State var isShowDatePicker2 = false
    
    var body: some View {
        ZStack{
            NavigationLink(destination: LeaveListView(), isActive: $isActive) {
                EmptyView()
            }.hidden()
            
            VStack(spacing: 10){
                
                HStack(spacing: 10){
                    Text("请假时间")
                    Button(action: {
                        self.isShowDatePicker1 = true
                    }) {
                        Group{
                            if let startDate = binding.startDate.wrappedValue{
                                Text(startDate.toString("yyyy-MM-dd") + " ~ " + (binding.endDate.wrappedValue?.toString("yyyy-MM-dd") ?? ""))
                                    .foregroundColor(Color(.label))
                            }else{
                                Text("请选择请假时间")
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
                    Text("请假理由")
                    TextField("请输入请假理由", text: binding.text)
                        .padding(.horizontal, 10)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }.frame(height: 54)
                
                MButton(text: "提交申请") {
                    Store.shared.sendLeave()
                }
                
                Spacer().onTapEndEditing()
                
            }.padding(.horizontal, 20)
            .font(.system(size: 14))
        }
        .navigationBarTitle("请假", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Text("申请记录")
                .bold()
                .font(.system(size: 14))
        })
        .overlay(Group{
            if isShowDatePicker1{
                startPickerView
            }else if isShowDatePicker2{
                endPickerView
            }else{
                EmptyView()
            }
        })
        .navigationBarItems(trailing: Button(action: {
            self.isActive.toggle()
        }) {
            Text("申请记录")
                .bold()
                .font(.system(size: 14))
        })
        .onReceive(binding.isSuccess.wrappedValue) { _ in
            self.isActive.toggle()
        }
    }
    
    var startPickerView: some View{
        OverlayView(title: "选择开始时间",
                    cancelAction: {
                        isShowDatePicker1 = false
                    }, okAction: {
                        binding.startDate.wrappedValue = startDate
                        isShowDatePicker1 = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            self.isShowDatePicker2 = true
                        }
                    }){
            DatePicker("", selection: $startDate, displayedComponents: [.date])
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .environment(\.locale, Locale(identifier: "zh_Hans_CN"))
        }
    }
    
    var endPickerView: some View{
        OverlayView(title: "选择结束时间",
                    cancelAction: {
                        isShowDatePicker2 = false
                    }, okAction: {
                        binding.endDate.wrappedValue = endDate
                        isShowDatePicker2 = false
                    }){
            DatePicker("", selection: $endDate, in: ($startDate.wrappedValue)..., displayedComponents: [.date])
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .environment(\.locale, Locale(identifier: "zh_Hans_CN"))
        }
    }
    
}

struct LeaveView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LeaveView()
        }
    }
}
