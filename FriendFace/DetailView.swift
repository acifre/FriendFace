//
//  DetailView.swift
//  FriendFace
//
//  Created by Anthony Cifre on 5/28/23.
//
//
//  DetailView.swift
//  SocialNetwork
//
//  Created by Anthony Cifre on 5/27/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    
    let user: CachedUser
    
    var body: some View {
        
        VStack {
            Form {
                ContactView(user: user, circleSize: 50)
                Section("Contact Info") {
                    
                    HStack(alignment: .top) {
                        Text("Joined:")
                        Spacer()
                        Text(user.wrappedRegistered, style: .date)
                    }
                    HStack(alignment: .top){
                        Text("Email:")
                        Spacer()
                        Text(user.wrappedEmail)
                    }
                    HStack(alignment: .top) {
                        Text("Address: ")
                        Spacer()
                        Text(user.wrappedAddress)
                    }
                    
                }
                Section("About") {
                        Text("\(user.age) years old")
                        Text(user.wrappedAbout)
                }
                Section("Tags") {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(user.tags?.components(separatedBy: ",") ?? [String](), id: \.self) { tag in
                            Text("#\(tag)")
                                .foregroundColor(.blue)
                        }
                    }
                }
                Section("Friends") {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(user.friendArray) { friend in
                            Text(friend.wrappedName)
                        }
                    }

                }

            }
            .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User())
//    }
//}
