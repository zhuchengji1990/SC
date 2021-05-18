//
//  CourseAction.swift
//  SC
//
//  Created by 沉寂 on 2021/5/18.
//

import Foundation
import LeanCloud

extension Store{
    
    func loadCourseList(){
        
        //加载今日的课程
        self.loadCoursePlan(isToday: true) { array in
            self.appState.home.courseArray = array
        }
        
        //加载全部课程
        self.loadCoursePlan(isToday: false) { array in
            self.appState.course.courseArray = array
        }
        
    }
    
    func loadCoursePlan(isToday: Bool = false, completion: @escaping ([LCObject]) -> Void){
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
    
   
    func loadCourse(completion: @escaping ([LCObject]) -> Void){
        self.showHud()
        let query = LCQuery(className: "Course")
        try? query.where("courseName", .ascending)
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
    
    
    func loadScheduleList(){
        guard let user = Store.shared.user else { return }
        self.showHud()
        let query = LCQuery(className: "Schedule")
        try? query.where("owner", .equalTo(user))
        try? query.where("startDate", .descending)
        try? query.where("coursePointer", .included)
        query.find { res in
            self.hideHud()
            switch res{
            case let .success(array):
                self.appState.home.scheduleArray = array
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
}



