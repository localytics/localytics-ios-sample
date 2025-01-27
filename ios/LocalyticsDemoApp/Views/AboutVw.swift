//
//  AboutVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 8/20/24.
//

import SwiftUI
import Localytics

struct AboutVw: View {
    var body: some View {
        NavigationView {
        ScrollView {
            VStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 0).foregroundColor(themeColor)
                        Text("About Localytics").font(.system(size: 36, weight: .bold, design: .default))
                            .foregroundColor(.white)
                       }
                    .frame(height: 100)
                }
                Spacer().frame(height: 10)
                VStack(alignment: .leading) {
                    Text("Purpose:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        
                    Text("The Localytics SDK helps you target and engage users of your iOS and Android apps. Use the Localytics Dashboard to configure and send personalized Push, In-App, and Inbox messages. You can also investigate and learn about your audience through their Events, Profiles, and other usage analytics.").font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    Spacer().frame(height: 20)
                    Text("Key Features:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Text("* Push Notifications").font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    Text("* In-App Messages").font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    Text("* Inbox Messages").font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    Text("* Events and Analytics").font(.system(size: 18, weight: .regular, design: .default))
                    Text("* Places").font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    HStack {
                        Image(uiImage: UIImage(named: "pushNoti")!)
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                        Text("Push Notification:")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Text("Pushes allow you to send personalized notifications and track their delivery via the Localytics dashboard. Using Liquid templating and A/B creatives, you can find the right messaging for each segment of your audience.").font(.system(size: 18, weight: .regular, design: .default))
                    HStack {
                        Image(uiImage: UIImage(named: "inApp")!)
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                        Text("In-App Messages:")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Text("In-Apps can be configured through the Localytics dashboard to display full-screen or banner pop-ups within the app. These pop-up messages can be further customized using our In-App Builder or your own JavaScript code.").font(.system(size: 18, weight: .regular, design: .default))
                    HStack {
                        Image(uiImage: UIImage(named: "inbox")!)
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                        Text("Inbox Messages:")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Text("The Inbox feature allows you to communicate directly with your users, to deliver targeted messages to them without having to reach out over email. This can be used for promo codes or other info relevant to your app.").font(.system(size: 18, weight: .regular, design: .default))
                    HStack {
                        Image(uiImage: UIImage(named: "event")!)
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                        Text("Events and Analytics:")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Text("Tag Event and Profile data throughout your app, and record these values for each individual user. Identify and tie this info together using their Customer ID. These analytics can provide valuable insights about how to interact your audience in the future.").font(.system(size: 18, weight: .regular, design: .default))
                    HStack {
                        Image(uiImage: UIImage(named: "place")!)
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                        Text("Places:")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Text("With Places, you can send notifications to users the instant they enter or exit a specific location. Additionally, you can analyze data about visits to physical locations, giving you access to insights that have never before been available.").font(.system(size: 18, weight: .regular, design: .default))
                    Spacer().frame(height: 20)
                    Text("Version:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        
                    Text("\(Localytics.libraryVersion() )").font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    Spacer().frame(height: 20)
                    Text("Privacy Policy:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    NavigationLink(destination: LoadWebVw(url: "https://uplandsoftware.com/localytics/app-privacy/")) {
                        Text("Click here for privacy policy.")
                            .font(.system(size: 18, weight: .regular, design: .default))
                            .foregroundColor(themeColor)
                    }
                        .foregroundColor(.black)
                    Spacer().frame(height: 20)
                    Text("Support:")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Spacer().frame(height: 5)
                    NavigationLink(destination: LoadWebVw(url: "https://help.uplandsoftware.com/localytics/help/Home.htm")) {
                        Text("Click Here to get support.")
                            .font(.system(size: 18, weight: .regular, design: .default))
                            .foregroundColor(themeColor)
                    }

                }
                .padding(10)
            }
        }
     }
    .navigationViewStyle(.stack)
    .onAppear {
        Localytics.tagScreen("About Screen")
     }
    }
}

#Preview {
    AboutVw()
}
