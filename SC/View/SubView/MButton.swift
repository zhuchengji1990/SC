//
//  MButton.swift
//  SleepCare
//
//  Created by 沉寂 on 2020/12/7.
//

import SwiftUI

struct MButton: View {
    var text: String
    var disabled: Binding<Bool> = .constant(false)
    var radius:CGFloat = 22
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(text.localizedString)
                .font(.subheadline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
        }
        .disabled(disabled.wrappedValue)
        .background(disabled.wrappedValue ? Color(.lightGray) : Color.theme)
        .cornerRadius(radius)
    }
}

struct MButton_Previews: PreviewProvider {
    static var previews: some View {
        MButton(text: "Test") {
            
        }
    }
}
