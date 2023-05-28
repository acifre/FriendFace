//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Anthony Cifre on 5/28/23.
//
//

import Foundation
import CoreData


extension CachedUser {
    
    

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var about: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var registered: Date?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var tags: String?
    @NSManaged public var friend: NSSet?
    
//    public var wrappedID: UUID {
//        id ?? UUID()
//    }
    public var wrappedID: UUID {
        id ?? UUID()
    }
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    public var wrappedAbout: String {
        about ?? "Unknown About"
    }
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    public var wrappedCompany: String {
        about ?? "Unknown Company"
    }
//    public var wrappedTags: [String] {
//
//        tags ?? [String]()
//    }
//    public var wrappedFriends: CachedFriend {
//        friend ?? CachedFriend()
//    }
    public var friendArray: [CachedFriend] {
        let set = friend as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

extension CachedUser : Identifiable {

}
