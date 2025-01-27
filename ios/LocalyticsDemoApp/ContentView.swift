import SwiftUI
import Localytics
import UserNotifications

struct PushRegisterView: View {
    @Binding var hasPromptedPush: Bool
    var body: some View {
        Button("Register for Push") {
            let notificationCenter = UNUserNotificationCenter.current()
            // actually pop up and ask the user for explicit push permission
            notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
                if granted {
                    DispatchQueue.main.sync {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
            hasPromptedPush = true
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct PushStatusView: View {
    @Binding var hasAcceptedPush: Bool
    @Binding var pushToken: String
    var body: some View {
        VStack(alignment: .leading) {
            HeaderVw(title: "PushNotification Feature", bckColor: themeColor)
            Spacer().frame(height: 10);
            Text("Info: After registration for push notification app will receive notification.").font(.system(size: 16, weight: .regular, design: .default)).padding(.horizontal, 5);
            Spacer().frame(height: 20)
            HStack() {
                RoundedRectangle(cornerRadius: 5)
                    .fill(hasAcceptedPush ? Color.green : Color.red)
                    .frame(width: 25, height: 25)
                    .overlay(content: {
                        Image(systemName: hasAcceptedPush ? "checkmark" : "xmark")
                            .foregroundColor(Color.white)
                    })
                Text(hasAcceptedPush ? "Ready to Receive" : "Push not Accepted, please check settings")
                    .padding(.leading, 10)
            }.padding(.leading, 5)
            Spacer().frame(height: 20);
            if hasAcceptedPush {
                TextField("Push Token", text: $pushToken)
                    .textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                Spacer().frame(height: 20)
            } else {
                Button("Open Settings") {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)")
                        })
                    }
                }
            }
            
        }.cardStyleVw(bckColor: .white, radius: 10, shadow: 5, shadowColor: themeLightGrayColor)
    }
    
}

//MARK: MAIN VIEW
struct ContentView: View {
    @State var isShowPopUp: Bool = false
    @State var hasPromptedPush = false
    @State var hasAcceptedPush = UIApplication.shared.isRegisteredForRemoteNotifications
    @State var pushToken = "My Push Token"
    @State var errorMsgForPopUp = ""
    @State var evName = ""
    @State var evAttrs: [(String, String)] = [
    ]
    
    static var pushStates: [UNAuthorizationStatus:String] = [
        .authorized: "Authorized",
        .denied: "Denied",
        .ephemeral: "Ephemeral",
        .notDetermined: "Not Determined",
        .provisional: "Provisional"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    VStack(alignment: .leading) {
                        Text("Push :").font(.system(size: 24, weight: .bold, design: .default))
                        VStack(alignment: .leading) {
                            //MARK: PushStatusView View
                            if !hasPromptedPush {
                                PushRegisterView(hasPromptedPush: $hasPromptedPush)
                            } else {
                                PushStatusView(hasAcceptedPush: $hasAcceptedPush, pushToken: $pushToken)
                            }
                        }
                        .padding(EdgeInsets(
                            top: 5,
                            leading: 5,
                            bottom: 5,
                            trailing: 5
                        ))
                        Spacer().frame(height: 40)
                        Text("In App Message :").font(.system(size: 24, weight: .bold, design: .default))
                        //MARK: InAppMsgVw View
                        InAppMsgVw(eventName: "", completionHandler: { (isValid, eventName) in
                            self.validateTxtFieldForInAppMsg(isValid: isValid, eventName:eventName);
                        })
                        
                        Spacer().frame(height: 40)
                        Text("Inbox Messaging:").font(.system(size: 24, weight: .bold, design: .default))
                        //MARK: Inbox View
                        InboxView()
                        Spacer().frame(height: 40)
                        
                        Text("Events :").font(.system(size: 24, weight: .bold, design: .default))
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear(perform: {
                        Localytics.tagScreen("Home Screen")
                        // check the state of the push authorization on view appear
                        let center = UNUserNotificationCenter.current()
                        center.getNotificationSettings(completionHandler: { settings in
                            let status = settings.authorizationStatus
                            
                            // whether or not we have used our "one ask" for push permission
                            self.hasPromptedPush = !(status == .notDetermined || status == .provisional)
                            self.hasAcceptedPush = status == .authorized || status == .ephemeral || status == .provisional
                        })
                        
                        // set push token (Localytics uses app delegate proxy to receive this from the remote notification registration method)
                        pushToken = Localytics.pushToken() ?? "N/A"
                    })
                    //MARK: Event View
                    VStack(alignment: .leading) {
                        HeaderVw(title: "Events Feature", bckColor: themeColor)
                        VStack(alignment: .leading) {
                            TextField("Event name", text: $evName).textFieldStyle(.roundedBorder).padding(.horizontal, 5)
                            ForEach(evAttrs.indices, id: \.self) { evIdx in
                                let attrName = evAttrs[evIdx].0
                                let attrVal = evAttrs[evIdx].1
                                HStack {
                                    TextField("Attribute Name", text: Binding(
                                        get: { return attrName },
                                        set: { (newValue) in  evAttrs[evIdx] = (newValue, attrVal) }
                                    ))
                                    TextField("Attribute Value", text: Binding(
                                        get: { return attrVal },
                                        set: { (newValue) in  evAttrs[evIdx] = (attrName, newValue) }
                                    ))
                                    Button("➖", action: {
                                        evAttrs.remove(at: evIdx)
                                    })
                                }
                            }
                            Button("Add Attribute", action: {
                                evAttrs.append(
                                    ("", "")
                                )
                            })
                            .buttonStyle(.borderedProminent)
                            
                            Spacer().frame(height: 40)
                            Button("Tag Event", action: {
                                if evAttrs.count == 0 {
                                    Localytics.tagEvent(evName)
                                } else {
                                    Localytics.tagEvent(evName, attributes: Dictionary(evAttrs, uniquingKeysWith: { (first, _) in first }))
                                }
                                self.errorMsgForPopUp = "Event tagged successfully."
                            
                            isShowPopUp = true
                            })
                            .buttonStyle(.borderedProminent)
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .padding(EdgeInsets(
                            top: 5,
                            leading: 10,
                            bottom: 5,
                            trailing: 10
                        ))
                    }
                    .cardStyleVw(bckColor: .white, radius: 10, shadow: 5, shadowColor: themeLightGrayColor)
                    .padding(.horizontal, 25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .navigationTitle("Localytics")
                .toolbarBackground(themeColor, for: .navigationBar)
                
                //isShowPopUp flag is used to display PoPup msg
                if isShowPopUp {
                    CustomPopUp(isShowPopUp: $isShowPopUp, title: "Message", msg: $errorMsgForPopUp, btnTitle: "OK") {
                        print("popup")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    
    //MARK: VALIDATIONS
    /*
     Function Name: validateTxtFieldForInAppMsg
     Description: This function use to check validation flag which is receive from InAppMsg View.
     And if the validation pass it will display popPup or call Localytics event method.
     */
    func validateTxtFieldForInAppMsg(isValid: Bool, eventName: String?) {
        if isValid {
            print("validation is pass")
            self.tagEventWithName(eventName: eventName!)
        } else {
            print("validation is fail")
            isShowPopUp = true;
            errorMsgForPopUp = "Please enter event name.";
        }
    }
    
    func tagEventWithName(eventName:String) {
        Localytics.tagEvent(eventName);
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
