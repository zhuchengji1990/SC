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
                
                ForEach(0..<20){ index in
                    NavigationLink(destination: ScheduleDetailView()){
                        ScheduleCell(title: "作业\(index)")
                    }
                    
                }
            }.padding(20)
            .background(Color(.secondarySystemBackground))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle(Date().toString("yyyy年MM月dd日"), displayMode: .automatic)
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
    var title: String
    var body: some View {
        HStack{
            Color(.orange).frame(width: 10)
            
            Text(title)
            Spacer()
            
            RoundedRectangle(cornerRadius: 2).strokeBorder(Color(.label), lineWidth: 1.0, antialiased: true)
                .frame(width: 16, height: 16)
            
        }.frame(height: 84)
        .padding(.trailing, 20)
        .foregroundColor(Color(.label))
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}
