//
//  PrivacyPolicyView.swift
//  BookKeeping
//
//  Created by 沉寂 on 2020/12/30.
//

import SwiftUI
//https://www.privacypolicies.com/live/03072924-faa1-4bab-a073-c123f0c3dfa4
struct PrivacyPolicyView: View {
    var body: some View {
        WebView(url: "https://www.privacypolicies.com/live/03072924-faa1-4bab-a073-c123f0c3dfa4")
            .navigationBarTitle("Privacy Policy", displayMode: .inline)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PrivacyPolicyView()
        }
    }
}

