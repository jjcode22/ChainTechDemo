//
//  HomeViewModel.swift
//  ChainTechDemo
//
//  Created by JJMac on 18/09/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var passwords: [Password] = []
    @Published var selectedPassword: Password?
    @Published var showAddScreen: Bool = false

    init() {
        fetchPasswords()
    }
    
    func fetchPasswords() {
        passwords = PasswordManager.shared.fetchPasswords()
    }
    
    func maskPassword(_ password: Password) -> String {
        let decryptedPassword = PasswordManager.shared.decryptPassword(password)
        return String(repeating: "*", count: decryptedPassword.count)
    }
    
    func selectPassword(_ password: Password) {
        selectedPassword = password
    }
    
    func addNewPassword() {
        showAddScreen = true
    }
    
    func closeAddPasswordScreen() {
        showAddScreen = false
        fetchPasswords()
    }
    
    func closePasswordDetailScreen() {
        selectedPassword = nil
        fetchPasswords()
    }
}
