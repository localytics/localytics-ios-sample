//
//  DemoAppDelegate.swift
//  LocalyticsDemoApp
//
//  Created by Philip Donlon on 5/31/23.
//

import Foundation
import UIKit
import Localytics
import UserNotifications
import SwiftUI
import CoreLocation

class DemoAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("initializing");
        Localytics.setLoggingEnabled(true)
        Localytics.setCallToActionDelegate(self);
        self.setDeepLinkingFlag(deeplinkFlag: true);
        self.setUpActionableNotification();
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Valid auth::::::::")
            Localytics.setLocationMonitoringEnabled(true)
          }
        Localytics.persistLocationMonitoring(true)
        return true
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("APNS didRegisterForRemoteNotifications. Got device token \(deviceToken)")
        Localytics.setPushToken(deviceToken)
    }
    
    
    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }
    
    func setUpActionableNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.sync {
                    UIApplication.shared.registerForRemoteNotifications()
                    if #available(iOS 12.0, *), objc_getClass("UNUserNotificationCenter") != nil {
                        let options: UNAuthorizationOptions = [.provisional]
                        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
                            Localytics.didRequestUserNotificationAuthorization(withOptions: options.rawValue, granted: granted)
                        }
                    }
                }
            }
        }
        
        notificationCenter.getNotificationSettings { settings in
            let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: .foreground)
            let shareAction = UNNotificationAction(identifier: "share", title: "Share", options: .foreground)
            let socialCategory = UNNotificationCategory(identifier: "social", actions: [likeAction, shareAction], intentIdentifiers: [], options: [])
            
            let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: .foreground)
            let rejectAction = UNNotificationAction(identifier: "reject", title: "Reject", options: .foreground)
            let decisionCategory = UNNotificationCategory(identifier: "decision", actions: [acceptAction, rejectAction], intentIdentifiers: [], options: [])

            let buyNowAction = UNNotificationAction(identifier: "buyNow", title: "Buy Now", options: .foreground)
            let skipAction = UNNotificationAction(identifier: "skip", title: "Skip", options: .foreground)
            let buyNowSkipCategory = UNNotificationCategory(identifier: "buyNowSkip", actions: [buyNowAction, skipAction], intentIdentifiers: [], options: [])
            
            let rateMeAction = UNNotificationAction(identifier: "rateMe", title: "Rate Me", options: .foreground)
            let remindMeLaterAction = UNNotificationAction(identifier: "remindMeLater", title: "Remind Me Later", options: .foreground)
            let rateMeRemindMeLaterCategory = UNNotificationCategory(identifier: "rateMeRemindMeLater", actions: [rateMeAction, remindMeLaterAction], intentIdentifiers: [], options: [])
            
            var categories = Set<UNNotificationCategory>()
            categories = [socialCategory,decisionCategory,buyNowSkipCategory,rateMeRemindMeLaterCategory]
            UNUserNotificationCenter.current().setNotificationCategories(categories)
        }
        
 
    }
    
    func setDeepLinkingFlag(deeplinkFlag: Bool) {
        UserDefaults.standard.set(deeplinkFlag, forKey: "deepLink")
        UserDefaults.standard.synchronize()
    }
    
    func checkDeepLinkIsRequired() -> Bool {
        if let isDeepLinkRequires = UserDefaults.standard.value(forKey: "deepLink") as? Bool {
            return isDeepLinkRequires
        } else {
           return true
        }
    }
}

extension DemoAppDelegate: UNUserNotificationCenterDelegate, LLCallToActionDelegate {


    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let userInfo = notification.request.content.userInfo as? [String : AnyObject] {
            
        }
        completionHandler(.alert)
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Localytics.didReceiveNotificationResponse(userInfo: response.notification.request.content.userInfo)
        print("payload:::: \(response.notification.request.content.userInfo)")
        switch response.actionIdentifier {
            case "like":
            print("like button clicked....")// handle like button
            self.setDeepLinkingFlag(deeplinkFlag: true);
        case "share":
            self.setDeepLinkingFlag(deeplinkFlag: false);
        case "accept":
            self.setDeepLinkingFlag(deeplinkFlag: false);
        case "reject":
            self.setDeepLinkingFlag(deeplinkFlag: true);
            default: break // handle other cases
          }
        completionHandler()
    }
    
    func localyticsShouldDeeplink(_ url: URL, campaign: LLCampaignBase?) -> Bool {
        //this method decides when deeplink should trigger or not based on flag value. if flag value is "true" deep link gets trigger.
        print("delegate method gets called:::::::::::::::::::::::::::::::");
        let deepLinkFlag = self.checkDeepLinkIsRequired()
        self.setDeepLinkingFlag(deeplinkFlag: true);
        return deepLinkFlag
    }
}
