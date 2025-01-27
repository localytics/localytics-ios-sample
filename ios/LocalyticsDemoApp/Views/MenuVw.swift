//
//  MenuVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 6/18/24.
//

import SwiftUI
import Localytics
struct CardView: View {
    let title: String
    let color: Color
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12).foregroundColor(color)
                NavigationLink(destination: Text(title)) {
                    Text(title)
                        .font(Font.custom("Baskerville-Bold", size: 36))
                        .foregroundColor(.white)
                }
            }
        }.onTapGesture {
            print("Cell \(title) tapped")
            
            if title == "Keys" {
                print("Cell \(title) tapped")
                
            }
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Hello world", color: Color.orange)
    }
}

struct MenuVw: View {
    @State var isDisplay: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer().frame(height: 40)
                Text("Localytics Features")
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .foregroundColor(themeColor)
                
                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).foregroundColor(themeGreenColor)
                            NavigationLink(destination: Keys()) {
                                Text("Keys")
                                    .font(.system(size: 36, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 100)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).foregroundColor(themeRedColor)
                            NavigationLink(destination: Host()) {
                                Text("Host")
                                    .font(.system(size: 36, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 100)
                        
                        
                    }
                    Spacer()
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).foregroundColor(themeOrangeColor)
                            NavigationLink(destination: Profile()) {
                                Text("Profile")
                                    .font(.system(size: 36, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 100)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).foregroundColor(themeColor)
                            NavigationLink(destination: Logs()) {
                                Text("Logs")
                                    .font(.system(size: 36, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 100)
                    }
                    Spacer()
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).foregroundColor(themeLightRedColor)
                            Button("Inbox") {
                                isDisplay = true
                            }
                            .font(.system(size: 36, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        }
                        .frame(height: 100)
                        
                        .sheet(isPresented: $isDisplay) {
                            InboxVc(isPresented: $isDisplay)
                        }
                        Spacer()
                        //blank view
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).foregroundColor(themeYellowColor)
                            NavigationLink(destination: PlacesVw()) {
                                Text("Places")
                                    .font(.system(size: 36, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 100)

                        
                    }
                }
                .padding()
                
            }
            .navigationTitle("Menu")
            .toolbarBackground(themeColor, for: .navigationBar)
            .onAppear {
                            Localytics.tagScreen("Menu Screen")
                        }
        }.navigationViewStyle(.stack)
    }
}



#Preview {
    MenuVw()
}
