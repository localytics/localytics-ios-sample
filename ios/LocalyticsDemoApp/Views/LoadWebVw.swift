//
//  LoadWebVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 8/20/24.
//

import SwiftUI

struct LoadWebVw: View {
    @State var url: String
        var body: some View {
            GeometryReader { geometry in

          ScrollView {
                  WKWebVw(url: URL(string: url)!)
                      .frame(height: geometry.size.height)
              }
          }
        }
}

#Preview {
    LoadWebVw(url: "www.apple.com")
}
