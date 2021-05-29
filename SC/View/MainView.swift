//
//  MainView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Main>{
        $store.appState.main
    }
    
    var hud: Binding<AppState.Hud>{
        $store.appState.hud
    }
    
    enum SheetItem: String, Identifiable{
        var id: String{
            self.rawValue
        }
        
        case confession
        case schedule
        case announcement
        case course
        case none
    }
    
    @State var sheetItem: SheetItem?
    
    
    var body: some View {
        NavigationView{
            
            VStack(spacing: 0){
                Group{
                    switch binding.selection.wrappedValue{
                    case 0:     HomeView()
                    case 1:     CourseView()
                    case 2:     ConfessionView()
                    default:    MyCenterView()
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .fullScreenCover(isPresented: $store.isUnLogin) {
                    LoginView().environmentObject(Store.shared)
                    
                }
                
                MTabView(selection: binding.selection)
                    .sheet(item: $sheetItem) { (item) in
                        Group{
                            switch item{
                            case .confession:
                                PublishConfessionView()
                            case .schedule:
                                PublishScheduleView()
                            case .announcement:
                                PublishAnnouncementView()
                            case .course:
                                AddCourseView()
                            default:
                                EmptyView()
                            }
                        }.environmentObject(Store.shared)
                    }
            }
            
            .navigationBarItems(
                leading: Menu {
                    Button("学生", action: {
                        $store.role.wrappedValue = .student
                    })
                    Button("教师", action: {
                        $store.role.wrappedValue = .teacher
                    })
                    Button("管理员", action: {
                        $store.role.wrappedValue = .admin
                    })
                } label: {
                    Text($store.role.wrappedValue.rawValue)
                        .frame(width: 64, height: 44)
                }, trailing: Menu {
                    Button("发布表白", action: {
                        self.sheetItem = .confession
                    })
                    Button("发布公告", action: {
                        self.sheetItem = .announcement
                    })
                    Button("发布待办事项", action: {
                        self.sheetItem = .schedule
                    })
                } label: {
                    Image(systemName: "plus.circle")
                        .frame(width: 44, height: 44)
                }
            )
        }.navigationViewStyle(StackNavigationViewStyle())
        .loading(isShowing: hud.isShowing)
        
        
        
        //        .fullScreenCover(isPresented: $store.isLogin){
        //            LoginView().environmentObject(Store.shared)
        //        }
        
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Store.shared)
    }
}


struct MTabView: View {
    @Binding var selection: Int
    @State var isPresented = false
    var body: some View{
        VStack(spacing: 0){
            Divider()
            
            HStack(alignment: .bottom, spacing: 0){
                Spacer()
                
                MTabCell(title: "首页", imgName: "house.fill", isSelect: selection == 0)
                    .onTapGesture {
                        selection = 0
                    }
                Spacer()
                
                MTabCell(title: "课表", imgName: "paperplane.fill", isSelect: selection == 1)
                    .onTapGesture {
                        selection = 1
                    }
                Spacer()
                
                MTabCell(title: "表白墙", imgName: "heart.text.square.fill", isSelect: selection == 2)
                    .onTapGesture {
                        selection = 2
                    }
                Spacer()
                
                
                MTabCell(title: "我的", imgName: "person.fill", isSelect: selection == 3)
                    .onTapGesture {
                        selection = 3
                    }
                Spacer()
            }
            .frame(height: 64)
            .padding(.horizontal, 10)
            .background(Color.background)
        }
    }
}

struct MTabCell: View {
    var title: String
    var imgName: String
    var isSelect: Bool
    var body: some View{
        VStack(spacing: 5){
            Image(systemName: imgName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(isSelect ? Color.theme : Color(.secondaryLabel))
            
            Text(title.localizedString)
                .font(.system(size: 13))
                .foregroundColor(isSelect ? Color.theme : Color(.secondaryLabel))
        }.frame(width: 64, height: 64)
    }
}
