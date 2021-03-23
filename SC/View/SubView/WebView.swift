//
//  WebView.swift
//  BookKeeping
//
//  Created by 沉寂 on 2020/12/30.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: String
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
      }

      func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: url) {
           let request = URLRequest(url: url)
           webView.load(request)
        }
      }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "www.baidu.com")
    }
}
