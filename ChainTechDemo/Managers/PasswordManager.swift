//
//  PasswordManager.swift
//  ChainTechDemo
//
//  Created by JJMac on 17/09/24.
//

import Foundation
import CoreData

class PasswordManager {
    static let shared = PasswordManager()

    let viewContext = PersistenceController.shared.container.viewContext
    let encryptionManager = EncryptionManager(key: "your-16-char-key", iv: "your-16-char-iv")

    // Save password
    func savePassword(accountName: String, username: String, password: String) {
        let encryptedPassword = encryptionManager.encrypt(password) ?? ""

        let newPassword = Password(context: viewContext)
        newPassword.accountName = accountName
        newPassword.username = username
        newPassword.password = encryptedPassword
        
        print("Password is \(password) Encypted password is \(encryptedPassword)")

        do {
            try viewContext.save()
            print("Password saved successfully.")
        } catch {
            print("Failed to save password: \(error)")
        }
    }

    // Fetch passwords
    func fetchPasswords() -> [Password] {
        let fetchRequest: NSFetchRequest<Password> = Password.fetchRequest()

        do {
            let passwords = try viewContext.fetch(fetchRequest)
            return passwords
        } catch {
            print("Failed to fetch passwords: \(error)")
            return []
        }
    }

    // Decrypt a password
    func decryptPassword(_ passwordEntity: Password) -> String {
        if let encryptedPassword = passwordEntity.password {
            return encryptionManager.decrypt(encryptedPassword) ?? ""
        }
        return ""
    }
    
    // Update password
    func updatePassword(passwordEntity: Password, newAccountName: String, newUsername: String, newPassword: String) {
        // Encrypt the new password
        let encryptedPassword = encryptionManager.encrypt(newPassword) ?? ""
        
        // Update the existing entity fields
        passwordEntity.accountName = newAccountName
        passwordEntity.username = newUsername
        passwordEntity.password = encryptedPassword
        
        print("Updating password. New encrypted password: \(encryptedPassword)")
        
        do {
            try viewContext.save()
            print("Password updated successfully.")
        } catch {
            print("Failed to update password: \(error)")
        }
    }
    
    // Delete password
    func deletePassword(passwordEntity: Password) {
        viewContext.delete(passwordEntity)
        
        do {
            try viewContext.save()
            print("Password deleted successfully.")
        } catch {
            print("Failed to delete password: \(error)")
        }
    }
}

