//
//  CircularLblVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/18/24.
//

import SwiftUI

struct CircularLblVw: View {
    var text: String
    var backgroundColor: Color
    var textColor: Color
    var size: CGFloat
    var body: some View {
        Text(text)
            .font(.system(size: size / 2))
            .foregroundColor(textColor)
            .frame(width: size, height: size)
            .background(backgroundColor)
            .clipShape(Circle())
            .overlay(Circle().stroke(textColor, lineWidth: 2))
            .shadow(radius: 5)
    }
}

#Preview {
    CircularLblVw(text: "2", backgroundColor: Color.blue, textColor: Color.black, size: 100)
}
