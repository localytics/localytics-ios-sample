//
//  WKWebVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 8/20/24.
//

import SwiftUI
import WebKit

struct WKWebVw: UIViewRepresentable {
    let url: URL
        
        func makeUIView(context: Context) -> WKWebView  {
            let wkwebView = WKWebView()
            let request = URLRequest(url: url)
            wkwebView.load(request)
            return wkwebView
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {
        }
}

#Preview {
    WKWebVw(url: URL(string: "www.apple.com")!)
}
