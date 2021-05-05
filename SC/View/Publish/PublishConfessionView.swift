//
//  PublishConfession.swift
//  SC
//
//  Created by 沉寂 on 2021/3/23.
//

import SwiftUI

struct PublishConfessionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Publish>{
        $store.appState.publish
    }
    
    var hud: Binding<AppState.Hud>{
        $store.appState.hud
    }
    
    @State var isPresented = false
    
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                
                Group{
                    if let img = binding.image.wrappedValue{
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }else{
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(70)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
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
               
                HStack{
                    Text("说点什么吧：").font(.system(size: 14))
                    Spacer()
                }
                
                
                TextEditor(text: binding.text)
                    .frame(height: 100)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                MButton(text: "发布", disabled: binding.isNextDisabled) {
                    Store.shared.publish(type: .confession)
                }
                
                
                Spacer()
                
                
            }.padding(20)
            .alert(item: binding.error) { (error) -> Alert in
                Alert(title: Text("提示"), message: Text(error.localizedDescription))
            }
            .onReceive(binding.isSuccess.wrappedValue) { (_) in
                self.presentationMode.wrappedValue.dismiss()
            }
            .navigationBarTitle("发布表白墙", displayMode: .inline)
            .navigationBarItems(leading: CloseBtn{
                self.presentationMode.wrappedValue.dismiss()
            })
        }.loading(isShowing: hud.isShowing)
        
    }
}

struct PublishConfession_Previews: PreviewProvider {
    static var previews: some View {
        PublishConfessionView().environmentObject(Store.shared)
    }
}
