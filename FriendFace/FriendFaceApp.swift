//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Anthony Cifre on 5/28/23.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
