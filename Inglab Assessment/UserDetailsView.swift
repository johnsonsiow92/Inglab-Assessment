//
//  UserDetailsView.swift
//  Inglab Assessment
//
//  Created by The Lorry Online on 25/10/2022.
//

import SwiftUI

struct UserDetailsView: View {
    var userDetails: UserItem
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                AsyncImage(
                    url: URL(string: userDetails.avatar),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    },
                    placeholder: {
                        ProgressView()
                    }).overlay(Rectangle().stroke(.gray, lineWidth: 0.5))
                HStack {
                    Image("icon_call")
                    Text(userDetails.phone)
                }.frame(maxWidth: .infinity)
                .padding()
                .overlay(Rectangle().stroke(.cyan, lineWidth: 2)).foregroundColor(.gray)
                HStack {
                    Image("icon_email")
                    Text(userDetails.email)
                }.frame(maxWidth: .infinity)
                    .padding()
                    .overlay(Rectangle().stroke(.cyan, lineWidth: 2)).foregroundColor(.gray)
                TextEditor(text: .constant(userDetails.description)).overlay(Rectangle().stroke(.gray, lineWidth: 1))
            }.frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
                .gesture(TapGesture().onEnded({ _ in
                    UIApplication.shared.dismissKeyboard()
                }))
        }.navigationTitle(userDetails.name)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static let dummyUser = UserItem(id: 1, index: 1, avatar: "https://i.postimg.cc/L5TGkxgk/Default-Male.png", name: "Test", phone: "0123456789", email: "test@testmail.com", description: "Hi I am testing", isActive: true)
    
    static var previews: some View {
        UserDetailsView(userDetails: dummyUser)
    }
}
