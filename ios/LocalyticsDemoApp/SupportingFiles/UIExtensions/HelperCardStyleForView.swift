//
//  HelperCardStyleForView.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 3/20/24.
//

import SwiftUI
// view extension for better modifier access
extension View {
    func cardStyleVw(bckColor: Color, radius: CGFloat, shadow: CGFloat, shadowColor: Color) -> some View {
            self.background(bckColor)
                .cornerRadius(radius)
                .shadow(color: shadowColor,radius: shadow)
        }
}
