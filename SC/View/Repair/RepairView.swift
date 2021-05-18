//
//  RepairView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI

struct RepairView: View {
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Repair>{
        $store.appState.repair
    }
    @State var isPresented = false
    
    @State var isActive = false
    
    var body: some View {
        ZStack{
            
            NavigationLink(destination: RepairListView(), isActive: $isActive) {
                EmptyView()
            }.hidden()
            
            VStack(spacing: 10){
                
                HStack(spacing: 10){
                    Text("报修地址")
                    
                   
                    TextField("", text: binding.address)
                        .padding(.horizontal, 10)
                        .frame(height: 44)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }.frame(height: 54)
                
                HStack(spacing: 10){
                    Text("问题描述")
                    TextField("", text: binding.text)
                        .padding(.horizontal, 10)
                        .frame(height: 44)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }.frame(height: 54)
                
                HStack(spacing: 10){
                    Text("添加图片（可选）")
                    
                    Spacer()
                    
                    Group{
                        if let img = binding.image.wrappedValue{
                            Image(uiImage: img)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }else{
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    .frame(width: 54, height: 54)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .onTapGesture {
                        self.isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented){
                        ImagePickerView(sourceType: .photoLibrary) { (img) in
                            binding.image.wrappedValue = img
                        }
                    }
                }.frame(height: 54)
                
                
                
                MButton(text: "提交申请") {
                    Store.shared.sendRepair()
                }
                
                Spacer().onTapEndEditing()
                
            }.padding(.horizontal, 20)
            
        }
        .font(.system(size: 14))
        .navigationBarTitle("报修", displayMode: .inline)
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
    
}

struct RepairView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RepairView().environmentObject(Store.shared)
        }
    }
}
