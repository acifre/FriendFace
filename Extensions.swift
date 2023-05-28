//
//  Extensions.swift
//  FriendFace
//
//  Created by Anthony Cifre on 5/28/23.
//

import Foundation

extension String {
    
    func initials(name: String) -> String {
        var initials = ""
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
             formatter.style = .abbreviated
             initials = formatter.string(from: components)
        }
        return initials
    }

}

