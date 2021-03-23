//
//  CloseBtn.swift
//  ContinuumEconomics
//
//  Created by DotSoft Ltd on 16/04/2020.
//  Copyright © 2020 DotSoft Ltd. All rights reserved.
//

import SwiftUI

struct CloseBtn: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .imageScale(.small)
                .frame(width: 24, height: 24)
                .background(Color(.systemBackground))
                .foregroundColor(Color(.secondaryLabel))
                .cornerRadius(15)
        }.frame(width: 44, height: 44, alignment: .center)
    }
}

struct CloseBtn_Previews: PreviewProvider {
    static var previews: some View {
        CloseBtn{}
    }
}
