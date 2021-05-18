//
//  CourseAction.swift
//  SC
//
//  Created by 沉寂 on 2021/5/18.
//

import Foundation
import LeanCloud

extension Store{
    
    func loadCourse(isToday: Bool = false, completion: @escaping ([LCObject]) -> Void){
        self.showHud()
        let query = LCQuery(className: "CoursePlan")
        try? query.where("coursePointer", .included)
        if isToday{
            try? query.where("date", .equalTo(Date().toString("yyyy-MM-dd")))
        }
        
        try? query.where("weekday", .ascending)
        try? query.where("week", .ascending)
        try? query.where("type", .ascending)
        query.find { res in
            self.hideHud()
            switch res{
            case let .success(array):
                completion(array)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func loadCourseList(){
        
        self.loadCourse(isToday: true) { array in
            self.appState.home.courseArray = array
        }
        
    }
    
    func loadScheduleList(){
        guard let user = Store.shared.user else { return }
        let query = LCQuery(className: "Schedule")
        try? query.where("owner", .equalTo(user))
        try? query.where("startDate", .descending)
        query.find { res in
            switch res{
            case let .success(array):
                self.appState.home.scheduleArray = array
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    
}



