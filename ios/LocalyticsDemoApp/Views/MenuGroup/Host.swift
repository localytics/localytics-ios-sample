//
//  Host.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/18/24.
//

import SwiftUI
import Localytics

struct Host: View {
    @State var isShowPopUp: Bool = false
    @State var msgForPopUp = "Options set successfully."
    @State private var isSSL = true
    @State var analyticHost = "analytics.localytics.com"
    @State var profileHost = "profile.localytics.com"
    @State var marketingHost = "analytics.localytics.com"
    @State var manifestHost = "manifest.localytics.com"
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    VStack(alignment: .leading) {
                        Text("  Info: Allow changing/configuring of the domains.").font(.system(size: 16, weight: .semibold, design: .default))
                        Spacer().frame(height: 20);
                        TextField("Enter analytic host name", text: $analyticHost)
                            .textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                        Spacer().frame(height: 20);
                        TextField("Enter profile host name", text: $profileHost).textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                        Spacer().frame(height: 20);
                        TextField("Enter marketing host name", text: $marketingHost).textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                        Spacer().frame(height: 20);
                        TextField("Enter manifest host name", text: $manifestHost).textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                        Spacer().frame(height: 20);
                        Toggle("SSL", isOn: $isSSL)
                        Spacer().frame(height: 20);
                        Button {
                            
                            
                            self.setLocalyticsOptions()
                            

                            
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
                        print("popup")
                    }
                 }
            }

        }
        .navigationTitle("Host")
        .onAppear{
                    Localytics.tagScreen("Logs Screen")
                }
    }
    
    func setLocalyticsOptions() {
        var optionsDict = [String : NSObject]()
        if analyticHost.count == 0 {
            //todo save nil value
            self.saveToUserDefaults(valueToSave: nil, keyForValue: HostKeys.analyticHost.rawValue)
            analyticHost = "analytics.localytics.com"
        } else {
            self.saveToUserDefaults(valueToSave: analyticHost, keyForValue: HostKeys.analyticHost.rawValue)
            print("values are present")
        }
        optionsDict[HostKeys.analyticHost.rawValue] = NSString(string: analyticHost);
        
        if profileHost.count == 0 {
            //todo save nil value
            self.saveToUserDefaults(valueToSave: nil, keyForValue: HostKeys.profileHost.rawValue)
            profileHost = "profile.localytics.com"
        } else {
            self.saveToUserDefaults(valueToSave: profileHost, keyForValue: HostKeys.profileHost.rawValue)
            print("values are present")
        }
        optionsDict[HostKeys.profileHost.rawValue] = NSString(string: profileHost)
        
        if marketingHost.count == 0 {
            self.saveToUserDefaults(valueToSave: nil, keyForValue: HostKeys.marketingHost.rawValue)
            marketingHost = "analytics.localytics.com"
            
        } else {
            self.saveToUserDefaults(valueToSave: marketingHost, keyForValue: HostKeys.marketingHost.rawValue)
            print("values are present")
        }
        optionsDict["messaging_host"] = NSString(string: marketingHost)
        if manifestHost.count == 0 {
            //todo save nil value
            self.saveToUserDefaults(valueToSave: nil, keyForValue: HostKeys.manifestHost.rawValue)
            manifestHost = "manifest.localytics.com"
        } else {
            self.saveToUserDefaults(valueToSave: manifestHost, keyForValue: HostKeys.manifestHost.rawValue)
            print("values are present")
        }
        optionsDict[HostKeys.manifestHost.rawValue] = NSString(string: manifestHost)
        
        optionsDict["use_https"] = NSNumber(value: isSSL);
        Localytics.setOptions(optionsDict)
        isShowPopUp = true
    }
    
    func saveToUserDefaults(valueToSave:String?, keyForValue: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(valueToSave, forKey: keyForValue)
        userDefaults.synchronize()
    }
}

#Preview {
    Host()
}
