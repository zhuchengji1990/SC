//
//  AddScoreView.swift
//  SC
//
//  Created by 沉寂 on 2021/5/18.
//

import SwiftUI
import LeanCloud

struct AddScoreView: View {
    
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Course>{
        $store.appState.course
    }
    
    @State var courseArray: [LCObject] = []
    @State var userArray: [LCObject] = []
    
    @State var user: LCObject?
    @State var isShowUser = false
    
    @State var isFirst = true
    
    var body: some View {
        VStack{
            HStack{
                Text("请先选择学生：")
                
                Button(action: {
                    self.isShowUser.toggle()
                }) {
                    Text(user?.get("name")?.stringValue ?? "点击选择")
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }
            }.padding(20)
            
            Group{
                if let user = user{
                    List{
                        ForEach(courseArray, id: \.self) { obj in
                            NavigationLink(
                                destination: AddScoreDetailView(course: obj, user: user),
                                label: {
                                    CourseCellView(obj: obj)
                                })
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }else{
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .navigationBarTitle("录入成绩", displayMode: .inline)
        .onAppear{
            if isFirst{
                isFirst = false
                Store.shared.loadCourse { array in
                    self.courseArray = array
                }
                
                Store.shared.loadUserList { array in
                    self.userArray = array
                }
            }
        }
        .sheet(isPresented: $isShowUser, content: {
            UserView(array: self.userArray) { user in
                self.user = user
            }
        })
    }
}

struct AddScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddScoreView().environmentObject(Store.shared)
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
    }
}
