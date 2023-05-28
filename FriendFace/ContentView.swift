//
//  ContentView.swift
//  SocialNetwork
//
//  Created by Anthony Cifre on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>

    @State private var users = [User]()
    
    var body: some View {
        
        NavigationView {
            List(cachedUsers, id: \.id) { user in
                    NavigationLink {
                        DetailView(user: user)

                    } label: {
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        Circle()
                                            .strokeBorder(lineWidth: 2)
                                            .foregroundColor(user.isActive ? .green : .gray)
                                    }
                                Text("\(user.wrappedName.initials(name: user.wrappedName))")
//                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .padding(1)
                            }
                            .padding(.trailing, 5)
                            VStack(alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .padding([.top, .bottom], 1)
                                Text(user.isActive ? "Online" : "Offline")
                                    .font(.caption)
                                    .foregroundColor(user.isActive ? .green: .secondary)
                            }
                        }
                    }
                    
                }
            .padding(2)
            .task {
                
                if cachedUsers.isEmpty || cachedUsers.count < 101 {
                    
                    if let retrievedUsers = await getUsers() {
                        users = retrievedUsers
                    }
                    
                    await MainActor.run {
                        
                        for user in users {
                            let newUser = CachedUser(context: moc)
                            newUser.id = user.id
                            newUser.name = user.name
                            newUser.about = user.about
                            newUser.address = user.address
                            newUser.isActive = user.isActive
                            newUser.age = Int16(user.age)
                            newUser.email = user.email
                            newUser.company = user.company
                            newUser.registered = user.registered
                            newUser.tags = user.tags.joined(separator: ",")
                            
                            for friend in user.friends {
                                let newFriend = CachedFriend(context: moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                newFriend.user = newUser
                            }
                            
                            try? moc.save()
                        }
                        
                    }
                }

            }
            .navigationTitle("FriendFace")
        }
}
    func getUsers() async -> [User]? {
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            if let decodedData = try? decoder.decode([User].self, from: data) {
                return decodedData
            }
        } catch {
            print("Invalid data")
        }
        return nil
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    @StateObject private var dataController = DataController()
    
    static var previews: some View {
        ContentView()

    }
}
