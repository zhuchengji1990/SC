//
//  HomeView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI
import LeanCloud

struct HomeView: View {
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Home>{
        $store.appState.home
    }
    
    
    @State var array = [LCObject]()
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                
                ForEach(binding.courseArray.wrappedValue){ obj in
                    NavigationLink(destination: CourseDetailView(obj: obj)){
                        CourseCell(obj: obj)
                    }
                }
                
                ForEach(binding.scheduleArray.wrappedValue){ obj in
                    NavigationLink(destination: ScheduleDetailView(obj: obj)){
                        ScheduleCell(obj: obj)
                    }
                }
                
                Spacer()
            }.padding(20)
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height)
            .background(Color(.secondarySystemBackground))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle(Date().toString("yyyy年MM月dd日"), displayMode: .automatic)
        .onAppear{
            Store.shared.loadScheduleList()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}


struct TypeCell: View{
    
    var title: String
    var imgName: String
    var color: Color
    var body: some View{
        VStack(spacing: 5){
            
            Image(systemName: imgName)
                .imageScale(.large)
                .frame(width: 54, height: 54)
                .background(color)
                .clipShape(Circle())
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
        }.frame(width: 80)
    }
    
    
}


struct CourseCell: View {
    var obj: LCObject
    var mColor: MColor{
        let tag = obj.get("colorTag")?.intValue ?? 0
        return mColorArray[tag]
    }
    
    var course: LCObject?{
        obj.get("coursePointer") as? LCObject
    }
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text(course?.get("courseName")?.stringValue ?? "").bold()
                    .font(.system(size: 22))
                Spacer()
            }
            
            
            mColor.color.frame(height: 2)
            
            HStack{
                Text(course?.get("address")?.stringValue ?? "").bold()
                Spacer()
            }
            
            HStack{
                Text(course?.get("note")?.stringValue ?? "").bold()
                Text((obj.get("type")?.intValue ?? 1).courseStr).bold()
                Spacer()
            }.font(.system(size: 14))
            .foregroundColor(Color(.secondaryLabel))
            
        }
        .padding(20)
        .foregroundColor(Color(.label))
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}


struct ScheduleCell: View {
    var obj: LCObject
    
    var course: LCObject?{
        obj.get("coursePointer") as? LCObject
    }
    
    var courseName: String{
        let course = obj.get("coursePointer") as? LCObject
        return course?.get("courseName")?.stringValue ?? ""
    }
    
    var mColor: MColor{
        let tag = course?.get("colorTag")?.intValue ?? 0
        return mColorArray[tag]
    }
    
    var body: some View {
        HStack(spacing: 5){
            mColor.color.frame(width: 10)
            VStack(alignment: .leading, spacing: 10){
                
                Text(obj.get("content")?.stringValue ?? "").bold()
                
                Text("所属课程：" + courseName)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                
                Text(obj.get("startDate")?.dateValue?.toString() ?? "")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.secondaryLabel))
                
            }.lineLimit(1)
            
            Spacer()
            
            Group{
            if obj.get("isFinish")?.boolValue ?? false{
                Text("已完成")
                    .foregroundColor(Color(.systemGreen))
            }else{
                Text("未完成")
                    .foregroundColor(Color(.systemRed))
            }
            }.font(.system(size: 14))
            
        }.frame(height: 104)
        .padding(.trailing, 20)
        .foregroundColor(Color(.label))
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}
