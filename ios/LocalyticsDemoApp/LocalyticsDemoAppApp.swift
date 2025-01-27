import SwiftUI
import Localytics

@main
struct LocalyticsDemoAppApp: App {
    @UIApplicationDelegateAdaptor(DemoAppDelegate.self) var appDelegate

    init() {
        self.integrateLocalytics()
    }
    
    func integrateLocalytics () {
        if !locaSDKInitialized {
            Localytics.autoIntegrate(appKey, launchOptions: nil)
            Localytics.setLoggingEnabled(true) //to print the logs
            locaSDKInitialized = true
        
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
