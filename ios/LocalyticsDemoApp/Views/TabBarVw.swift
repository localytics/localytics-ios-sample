//
//  TabBarVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/10/24.
//

import SwiftUI

struct TabBarVw: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Text("Home view")
                    Image(systemName: "house.fill")
                        .renderingMode(.template)
                }
            
            CustomerIdContainerVw()
                .tabItem{
                    Text("Customer ID")
                    Image(systemName: "person.fill")
                }
            MenuVw()
                .tabItem{
                    Text("Features")
                    Image(systemName: "square.grid.3x3")
                }
            AboutVw()
                .tabItem{
                    Text("About")
                    Image(systemName: "info.square.fill")
                }
        }
                .tint(.blue)
                .onAppear(perform: {
                    UITabBar.appearance().unselectedItemTintColor = themeGrayColor
                    UITabBarItem.appearance().badgeColor = .systemPink
                    UITabBar.appearance().backgroundColor = tabBarColor
                    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                    let appearance = UITabBarAppearance()
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                    
                })
        
        
    }
}

#Preview {
    TabBarVw()
}
