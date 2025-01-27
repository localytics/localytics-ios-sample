//
//  InAppMsgVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 5/21/24.
//

import SwiftUI

//MARK: IN APP MESSAGE
struct InAppMsgVw: View {
    @State var eventName: String
    var completionHandler: (_ isValid: Bool, _ eventName: String?) -> Void
    var body: some View {
            VStack(alignment: .leading) {
                HeaderVw(title: "InAppMessage Feature", bckColor:  themeColor)
                Spacer().frame(height: 10);
                
                Text("Info: It will display popup after performing any specific event.").font(.system(size: 16, weight: .regular, design: .default)).padding(.horizontal, 5);
                Spacer().frame(height: 20);
                TextField("Enter Event name", text: $eventName).textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                Spacer().frame(height: 20);
                
                Button("Submit") {
                    if eventName.count == 0 {
                        completionHandler(false,nil)
                        print("InApp msg button action");
                        }
                    else {
                        completionHandler(true, eventName)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .center)
        }.cardStyleVw(bckColor: .white, radius: 10, shadow: 5, shadowColor: themeLightGrayColor)
    }
}

#Preview {
    InAppMsgVw(eventName: "Test") { isValid, eventName in }
}
