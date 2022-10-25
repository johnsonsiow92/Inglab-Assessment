//
//  UserListViewModel.swift
//  Inglab Assessment
//
//  Created by The Lorry Online on 24/10/2022.
//

import Alamofire
import Foundation

class UserListViewModel: ObservableObject {
    
    @Published var userList: [UserItem] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getUserList() async {
        guard let data = try?  await  APIService().getUserList() else {
            self.userList = []
            self.hasError = true
            self.errorMessage  = "Server Error"
            return
        }
           
        DispatchQueue.main.async {
            self.userList = data
        }
    }
}
