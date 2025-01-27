//
//  Profile.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/18/24.
//

import SwiftUI
import Localytics
struct Profile: View {
    @State var isShowPopUp: Bool = false
    @State var msgForPopUp = "Profile attribute added successfully."
    @State var isScope = true
    @State var profileAttribute = ""
    @State var profileValue = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    VStack(alignment: .leading) {
                        Text("  Info: Set profile attribute and profile value.").font(.system(size: 16, weight: .semibold, design: .default))
                        Spacer().frame(height: 20);
                        TextField("Enter profile attribute", text: $profileAttribute)
                            .textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                        Spacer().frame(height: 20);
                        TextField("Enter profile value", text: $profileValue).textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                        Spacer().frame(height: 20);
                        Toggle("Scope 'Org' ('App' by default)", isOn: $isScope)
                        Spacer().frame(height: 20);
                        Button {
                            setProfile()
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
        .navigationTitle("Profile")
        .onAppear {
                    Localytics.tagScreen("Profile Screen")
                }
    }
    
    func setProfile() {
        var attribute = self.profileAttribute
        var value = self.profileValue
        var profileScope = LLProfileScope.application
        if self.isScope {
            profileScope = LLProfileScope.organization
        } else {
        }
        Localytics.addValues([value], toSetForProfileAttribute: attribute, with: profileScope)
        isShowPopUp = true
    }
    
    
}

#Preview {
    Profile()
}
