//
//  CustomerIDLogoutVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/3/24.
//

import SwiftUI
//CustomerIDLogoutVw

//MARK: Customer ID Logout View
struct CustomerIDLogoutVw: View {
    @State var customerID: String
    var completionHandler: (_ isValid: Bool, _ customerID: String?) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HeaderVw(title: "CustomerId Reset Feature", bckColor: themeColor)
            Spacer().frame(height: 10);
            
            Text("Info: It will reset customer ID.").font(.system(size: 16, weight: .regular, design: .default)).padding(.horizontal, 5);
            Spacer().frame(height: 20);
            TextField("Enter Customer ID", text: $customerID).textFieldStyle(.roundedBorder).padding(.horizontal, 5)
            Spacer().frame(height: 20);
            
            Button("Logout                   ") {
                if customerID.count == 0 {
                    completionHandler(false,nil)
                    print("Remove Customer ID button action");
                }
                else {completionHandler(true, customerID)}
            }
            .buttonStyle(.borderedProminent)
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .center)
        }.cardStyleVw(bckColor: .white, radius: 10, shadow: 5, shadowColor: themeLightGrayColor)
    }
}

#Preview {
    CustomerIDLogoutVw(customerID: "123") { isValid, eventName in }
}
