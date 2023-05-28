//
//  ContactView.swift
//  FriendFace
//
//  Created by Anthony Cifre on 5/28/23.
//

import SwiftUI

struct ContactView: View {
    @Environment(\.managedObjectContext) var moc
    
    let user: CachedUser
    let circleSize: CGFloat
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.black)
                    .frame(width: circleSize, height: circleSize)
                    .overlay {
                        Circle()
                            .strokeBorder(lineWidth: 2)
                            .foregroundColor(user.isActive ? .green : .gray)
                    }
                Text("\(user.wrappedName.initials(name: user.wrappedName))")
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

//struct ContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactView()
//    }
//}
