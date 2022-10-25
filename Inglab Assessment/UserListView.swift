//
//  UserListView.swift
//  Inglab Assessment
//
//  Created by The Lorry Online on 23/10/2022.
//

import SwiftUI

struct UserListView: View {
    @StateObject var vm = UserListViewModel()
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Inglab Assessment")
                SearchBar(searchText: $searchText, searching: $searching)
                List {
                    ForEach(vm.userList.sorted().filter({ (user: UserItem) -> Bool in
                        return user.name.hasPrefix(searchText) || user.phone.hasPrefix(searchText) || searchText == ""
                    })) { user in
                        if user.isActive {
                            HStack {
                                AsyncImage(
                                    url: URL(string: user.avatar),
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 75, height: 75)
                                    },
                                    placeholder: {
                                        ProgressView()
                                    })
                                VStack (alignment: .leading) {
                                    Text(user.name)
                                    Text(user.phone)
                                }
                                NavigationLink("", destination: UserDetailsView(userDetails: user)).navigationBarTitle("", displayMode: .inline)
                            }
                        }
                    }
                }
                .task {
                    await vm.getUserList()
                }.toolbar {
                    if searching {
                        Button("Cancel") {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }
                }.gesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.dismissKeyboard()
                }))
            }.padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 24))
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText) { startedEdittng in
                if startedEdittng {
                    withAnimation {
                        searching = true
                    }
                }
            } onCommit: {
                withAnimation {
                    searching = false
                }
            }
            Image("icon_search")
        }.padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2)).foregroundColor(.gray)
    }
}
