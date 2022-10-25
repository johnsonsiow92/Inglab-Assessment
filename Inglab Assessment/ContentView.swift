//
//  ContentView.swift
//  Inglab Assessment
//
//  Created by The Lorry Online on 21/10/2022.
//

import AlertToast
import SwiftUI

struct ContentView: View {
    @State var isPresentingAlert = false
    @State var isPresenting = false
    @State var isSecured = true
    @State var inputUsername = ""
    @State var inputPassword = ""
    
    @State var alertType: AlertToast.AlertType = .error(.red)
    @State var alertMessage = ""
    
    let dummyLoginDB = [
        LoginUser(username: "Testing", password: "12345678"),
        LoginUser(username: "Admin123", password: "Password"),
        LoginUser(username: "User1234", password: "4321User")
    ]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        Image("AppLogo")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("Inglab Assessment")
                        HStack {
                            Image("icon_user")
                            TextField("Username", text: $inputUsername)
                        }.padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2)).foregroundColor(.gray)
                        HStack {
                            Image("icon_password")
                            SecureInputView("Password", text: $inputPassword)
                        }.padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2)).foregroundColor(.gray)
                        Spacer()
                        Button(action: {
                            login()
                        }) {
                            Text("Login")
                                .frame(width: geometry.size.width - 48, height: 50)
                                .background(Color.cyan)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                        if #available(iOS 16.0, *) {
                            NavigationLink(destination: UserListView().toolbar(.hidden), isActive: $isPresenting) {
                                EmptyView()
                            }
                        } else {
                            NavigationLink(destination: UserListView().navigationBarHidden(true), isActive: $isPresenting) {
                                EmptyView()
                            }
                        }
                    }.frame(maxWidth: .infinity)
                        .frame(height: geometry.size.height)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                }
            }
        }.toast(isPresenting: $isPresentingAlert, alert: {
            AlertToast(type: alertType, title: alertMessage)
        })
    }
    
    func login() {
        print("Logging in....")
        if dummyLoginDB.firstIndex(where: {$0.username == inputUsername.trimmingCharacters(in: .whitespaces) && $0.password == inputPassword.trimmingCharacters(in: .whitespaces)}) != nil {
            print("Login success")
            alertType = .complete(.green)
            alertMessage = "Welcome, \(inputUsername)"
            isPresenting = true
        } else {
            print("Login failed")
            alertType = .error(.red)
            alertMessage = "Incorrect username or password"
            isPresentingAlert.toggle()
            isPresenting = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(self.isSecured ? "icon_eye_close" : "icon_eye_open")
                    .accentColor(.gray)
            }
        }
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
