//
//  DataController.swift
//  FriendFace
//
//  Created by Anthony Cifre on 5/28/23.
//

import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FriendFace")
    
    init() {
//        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
//        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
