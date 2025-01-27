//
//  CustomerIdContainerVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/10/24.
//

import SwiftUI
import Localytics

struct CustomerIdContainerVw: View {
    @State var isShowPopUp: Bool = false
    @State var errorMsgForPopUp = ""
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    VStack(alignment: .leading) {
                        //MARK: CustomerIdVw View
                        CustomerIdVw(customerID: "\(String(describing: Localytics.customerId() ?? ""))", completionHandler: {(isValid, customerID) in
                            self.validateTxtFieldForCustomerID(isValid: isValid, customerID: customerID);
                        })
                        Spacer().frame(height: 40)
                        //MARK: CustomerIDLogoutVw View
                        CustomerIDLogoutVw(customerID: "\(String(describing: Localytics.customerId() ?? ""))", completionHandler: {(isValid, customerID) in
                            self.validateTxtFieldForCustomerIDLogout(isValid: isValid, customerID: customerID);
                        })
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .navigationTitle("CustomerID")
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
        .onAppear{
                    Localytics.tagScreen("CustomerID Screen")
                }
    }
    
    //MARK: VALIDATION
    /*
     Function Name: validateTxtFieldForCustomerID
     Description: This function use to check validation flag which is receive from CustomerIdView.
     And if the validation pass then it call set customerID method.
     */
    func validateTxtFieldForCustomerID(isValid: Bool, customerID: String?) {
        if isValid {
            print("validation is pass")
            
            self.settingCustomerID(customerID: customerID!);
        } else {
            print("default customer id is \(String(describing: Localytics.customerId()))");
            print("validation is fail")
            isShowPopUp = true
            errorMsgForPopUp = "Please enter customerID.";
        }
    }
    /*
     Function Name: validateTxtFieldForCustomerIDLogout
     Description: This function use to check validation flag which is receive from CustomerIdView.
     And if the validation pass then it call logout customerID method.
     */
    func validateTxtFieldForCustomerIDLogout(isValid: Bool, customerID: String?) {
        if isValid {
            print("validation is pass")
            let dict = ["customer_id":"\(String(describing: customerID))"];
            self.logoutCustomerID(dict: dict);
        } else {
            print("validation is fail")
            isShowPopUp = true
            errorMsgForPopUp = "Please enter customerID.";
        }
    }
    /*
     Function Name: settingCustomerID
     Description: it will Set customerID.
     */
    func settingCustomerID(customerID: String) {
        Localytics.setCustomerId(customerID);
        isShowPopUp = true
        errorMsgForPopUp = "CustomerID set successfully.";
    }
    /*
     Function Name: logoutCustomerID
     Description: it will reset customerID.
     */
    func logoutCustomerID(dict: [String: String]) {
        Localytics.tagCustomerLoggedOut(dict);
        isShowPopUp = true
        errorMsgForPopUp = "CustomerID reset successfully.";
    }
}

#Preview {
    CustomerIdContainerVw()
}
