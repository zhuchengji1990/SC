//
//  QueryScoreView.swift
//  SC
//
//  Created by 沉寂 on 2021/3/29.
//

import SwiftUI

struct QueryScoreView: View {
    var body: some View {
        Text("Hello, World!")
            .navigationBarTitle("成绩查询", displayMode: .inline)
    }
}

struct QueryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            QueryScoreView()
        }
    }
}
