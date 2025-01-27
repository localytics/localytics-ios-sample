//
//  SplashView.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 4/15/24.
//

import SwiftUI
import Localytics


struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive {
            TabBarVw()
        } else {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                VStack {
                    VStack {
                        Image(uiImage: UIImage(named: "analytics1")!)
                            .resizable()
                            .frame(width: 100.0, height: 100.0)
                        Spacer().frame(height: 10)
                        Text("Localytics")
                            .font(.system(size: 60, weight: .bold, design: .default))
                            .foregroundColor(.white)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    Localytics.tagScreen("Splash Screen")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation {
                            self.isActive = true
                            // self.integrateLocalytics()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

    func integrateLocalytics () {
        if !locaSDKInitialized {
            Localytics.setLoggingEnabled(true) //to print the logs
            Localytics.autoIntegrate(appKey, launchOptions: nil)
            locaSDKInitialized = true
        }
    }
}

#Preview {
    SplashView()
}
