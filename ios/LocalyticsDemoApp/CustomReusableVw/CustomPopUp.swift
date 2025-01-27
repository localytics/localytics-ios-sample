//
//  CustomPopUp.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 3/28/24.
//

import SwiftUI

struct CustomPopUp: View {
    @Binding var isShowPopUp: Bool
    let title: String
    @Binding var msg: String
    let btnTitle: String
    let btnAction: () -> ()
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack {
            Color(.white)
                .opacity(0.1)
                .onTapGesture {
                    closePopUp()
                }
            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()
                
                Text(msg)
                    .font(.body)
                Button {
                    btnAction()
                    closePopUp()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(themeColor)
                        
                        Text(btnTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .padding()
            .cardStyleVw(bckColor: .white, radius: 10, shadow: 5, shadowColor: themeLightGrayColor)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
    }
    func closePopUp() {
        withAnimation(.spring()) {
            offset = 1000
            isShowPopUp = false
        }
    }
}

#Preview {
    CustomPopUp(isShowPopUp: .constant(true),title: "Error", msg: .constant("Please Enter"), btnTitle: "OK") {
        
    }
}
