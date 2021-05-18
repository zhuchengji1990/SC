//
//  ScheduleView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/22.
//

import SwiftUI
import LeanCloud

struct CourseView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Post>{
        $store.appState.post
    }
    
    @State var array = [LCObject]()
    
    var body: some View {
        List{
            ForEach(array, id: \.self) { obj in
                InfoCell(obj: obj)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).navigationBarTitle("课表", displayMode: .inline)
        .onAppear{
            Store.shared.loadCourse { array in
                self.array = array
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CourseView().environmentObject(Store.shared)
        }
    }
}


private struct InfoCell: View{
    var obj: LCObject
    var course: LCObject?{
        obj.get("coursePointer") as? LCObject
    }
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(course?.get("courseName")?.stringValue ?? "").bold()
                .font(.system(size: 18))
                .foregroundColor(Color(.label))
            HStack{
                Text("@" + (course?.get("address")?.stringValue ?? ""))
                Text(course?.get("teacherName")?.stringValue ?? "")
                Spacer()
            }
            HStack{
                Text(course?.get("note")?.stringValue ?? "")
                
                
                Spacer()
                
                
                Text((obj.get("weekday")?.intValue ?? 1).weekStr)
                
                Text((obj.get("type")?.intValue ?? 1).courseStr)
            }
        }.font(.system(size: 14))
        .foregroundColor(Color(.secondaryLabel))
    }
}

