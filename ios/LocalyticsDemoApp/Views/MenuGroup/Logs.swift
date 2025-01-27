//
//  Logs.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/18/24.
//

import SwiftUI
import Localytics

struct Logs: View {
    @State var isShowPopUp: Bool = false
    @State var msgForPopUp = ""
    @State private var isLoggingEnable = true
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    VStack(alignment: .leading) {
                        Text("  Info: Set to YES to enable logging and NO to disable it.").font(.system(size: 16, weight: .semibold, design: .default))
                        Spacer().frame(height: 20);
                        
                        Toggle("Logging: ", isOn: $isLoggingEnable)
                        Spacer().frame(height: 20);
                        Button {
                            setLogging()
                        } label: {
                            Text("Set")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                //isShowPopUp flag is used to display PoPup msg
                if isShowPopUp {
                    CustomPopUp(isShowPopUp: $isShowPopUp, title: "Message", msg: $msgForPopUp, btnTitle: "OK") {
                    }
                }
            }
            
        }
        .navigationTitle("Logs")
        .onAppear{
                    Localytics.tagScreen("Logs Screen")
                }
    }
    
    func setLogging() {
        
        if self.isLoggingEnable {
         Localytics.setLoggingEnabled(true)
            self.msgForPopUp = "Logging enabled successfully."
        } else {
            Localytics.setLoggingEnabled(false)
            self.msgForPopUp = "Logging disabled successfully."
        }
        
        isShowPopUp = true
    }
}

#Preview {
    Logs()
}
