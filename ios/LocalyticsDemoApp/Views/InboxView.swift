import SwiftUI
import Localytics

//MARK: INBOX MESSAGE
struct InboxView: View {
    
    @State var inboxLoaded = false
    @State var inboxCount = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderVw(title: "Inbox Feature", bckColor: themeColor)
            Spacer().frame(height: 10);
            HStack {
                Text("Count:")
                Text(!inboxLoaded ? "Loading Inbox campaigns..." : "Loaded Messages")
                CircularLblVw(text: "\(inboxCount)", backgroundColor: themeColor, textColor: .black, size: 30)
            }
            .padding(10)
            .onAppear {
                print("onAppear get called:::::::::::::::::::::::::::::");
                // try to load inbox campaigns from loca
                Localytics.refreshInboxCampaigns({ res in
                    // we got the reply, so let's update our UI
                    Localytics.tagScreen("Inbox Screen")
                    print("We got the inbox response back::::::::::::::::::::::::::::::: \(String(describing: res))")
                    if let campaigns = res {
                        inboxCount = campaigns.count
                        print("count is \(campaigns.count)")
                        inboxLoaded = true
                    } else {
                        print("Something else happened (nil from callback)")
                    }
                })
            }
        }.cardStyleVw(bckColor: .white, radius: 10, shadow: 5, shadowColor: themeLightGrayColor)
    }
}
