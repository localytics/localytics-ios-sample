//
//  Constants.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 3/28/24.
//

import Foundation
import SwiftUI

//Custom colors
let themeColor = Color.cyan
let tabBarColor = UIColor.cyan
let themeLightGrayColor = Color.gray
let themeGrayColor = UIColor.lightGray
let themeYellowColor = Color.yellow
let themeOrangeColor = Color(red: 213/255, green: 100/255, blue: 54/255, opacity: 1)
let themeRedColor = Color(red: 100/255, green: 100/255, blue: 54/255, opacity: 1)
let themeGreenColor = Color(red: 50/255, green: 100/255, blue: 54/255, opacity: 1)
let themeLightRedColor = Color(red: 229/255, green: 115/255, blue: 115/255, opacity: 1)
var appKey = "ee48b3f5a943fb43b40e539-86732b9e-fff9-11ed-0ca6-007c928ca240"
var locaSDKInitialized = false

//MARK: Enum for HOST Keys

enum HostKeys: String {
    case analyticHost = "analytics_host"
    case profileHost = "profiles_host"
    case marketingHost = "marketing_host"
    case manifestHost = "manifest_host"
}
