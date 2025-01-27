//
//  Keys.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/18/24.
//

import SwiftUI
import Localytics

struct Keys: View {
    @State var installId = "NA"
    @State var appKey = "NA"
    @State var pushKey = "NA"
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Total Keys :  ").font(Font.custom("Baskerville-Bold", size: 28))
                                .foregroundColor(themeColor)
                            CircularLblVw(text: "3", backgroundColor: themeOrangeColor, textColor: .black, size: 50)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer().frame(width: 20);
                                Image(uiImage: UIImage(named: "installID")!)
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                Text("Install ID").font(Font.custom("Baskerville-Bold", size: 28))
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer().frame(height: 10);
                            
                            Text(installId).font(.system(size: 16, weight: .regular, design: .default)).padding(.horizontal, 5)
                            Spacer().frame(height: 20);
                        }
                        .cardStyleVw(bckColor: Color.white, radius: 10, shadow: 5,shadowColor: themeOrangeColor)
                        Spacer().frame(height: 20);
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer().frame(width: 20);
                                Image(uiImage: UIImage(named: "appKey")!)
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                Text("App Key").font(Font.custom("Baskerville-Bold", size: 28))
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer().frame(height: 10);
                            
                            Text(appKey).font(.system(size: 16, weight: .regular, design: .default)).padding(.horizontal, 5)
                            Spacer().frame(height: 20);
                        }
                        .cardStyleVw(bckColor: Color.white, radius: 10, shadow: 5,shadowColor: themeOrangeColor)
                        Spacer().frame(height: 20);
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer().frame(width: 20);
                                Image(uiImage: UIImage(named: "pushNoti")!)
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                Text("Push Token").font(Font.custom("Baskerville-Bold", size: 28))
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer().frame(height: 10);
                            
                            Text(pushKey).font(.system(size: 16, weight: .regular, design: .default)).padding(.horizontal, 5)
                            Spacer().frame(height: 20);
                        }
                        .cardStyleVw(bckColor: Color.white, radius: 10, shadow: 5,shadowColor: themeOrangeColor)

                     }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear(perform: {
                        installId = Localytics.installId() ?? "NA"
                        appKey = Localytics.appKey() ?? "NA"
                        pushKey = Localytics.pushToken() ?? "NA"
                        Localytics.tagScreen("Keys Screen")
                    })
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    Keys()
}
