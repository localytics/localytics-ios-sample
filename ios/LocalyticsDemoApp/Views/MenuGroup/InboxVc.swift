//
//  InboxViewController.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 8/8/24.
//

import SwiftUI
import Localytics

struct InboxVc: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    func makeUIViewController(context: Context) -> some UIViewController {
        let inboxVcObj = LLInboxViewController()
        let navObj = UINavigationController(rootViewController: inboxVcObj)
        navObj.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        navObj.modalPresentationStyle = .overCurrentContext
        return navObj
    }
    
    
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if !isPresented {
            uiViewController.dismiss(animated: true)
        }
    }
}


