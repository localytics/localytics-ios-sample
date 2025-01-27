//
//  HeaderVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 3/20/24.
//

import SwiftUI

struct HeaderVw: View {
    @State var title: String
    @State var bckColor: Color
    var body: some View {
            HStack {
                Text("# " + title + " #").font(.system(size: 18, weight: .semibold, design: .default))
                    .frame(maxWidth: .infinity)
                    .padding(10).background(Color.clear)
            }
            .background(bckColor)
            
       
    }
}

#Preview {
    HeaderVw(title: "Header", bckColor: themeColor)
}
