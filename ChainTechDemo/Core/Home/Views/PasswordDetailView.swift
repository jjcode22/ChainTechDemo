//
//  PasswordDetailView.swift
//  ChainTechDemo
//
//  Created by JJMac on 18/09/24.
//

import SwiftUI

struct PasswordDetailView: View {
    @State private var isPasswordHidden: Bool = true
    @State private var isEditing: Bool = false
    @State private var editedAccountName: String = ""
    @State private var editedUsername: String = ""
    @State private var editedPassword: String = ""
    @State private var showDeleteConfirmation: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    @Environment(\.presentationMode) var presentationMode
    
    var password: Password
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            VStack(alignment: .leading, spacing: isEditing ? 10 : 20) {
                Text("Account Details")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.blue)
                
                VStack(alignment: .leading) {
                    Text("Account Type")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray.opacity(0.7))
                        .bold()
                    if isEditing {
                        TextField("Account Name", text: $editedAccountName)
                            .textFieldStyle(OutlinedTextFieldStyleSmall())
                    } else {
                        Text(password.accountName ?? "Unknown")
                            .font(.title3)
                            .bold()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Username/Email")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray.opacity(0.7))
                        .bold()
                    if isEditing {
                        TextField("Username", text: $editedUsername)
                            .textFieldStyle(OutlinedTextFieldStyleSmall())
                    } else {
                        Text(password.username ?? "Unknown")
                            .font(.title3)
                            .bold()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray.opacity(0.7))
                        .bold()
                    if isEditing {
                        SecureField("Password", text: $editedPassword)
                            .textFieldStyle(OutlinedTextFieldStyleSmall())
                    } else {
                        HStack {
                            Text(isPasswordHidden ? maskedPassword(for: password) : PasswordManager.shared.decryptPassword(password))
                                .font(.title3)
                                .bold()
                            Spacer()
                            Button(action: {
                                isPasswordHidden.toggle()
                            }) {
                                Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    if isEditing {
                        // Cancel Button
                        Button(action: {
                            isEditing = false // Cancel editing
                        }) {
                            Text("Cancel")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(30)
                                .shadow(color: .gray.opacity(0.15), radius: 2, x: 2, y: 2)
                        }
                        
                        // Save Button
                        Button(action: {
                            validateFields() // Validate before saving
                        }) {
                            Text("Save")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(30)
                                .shadow(color: .green.opacity(0.15), radius: 2, x: 2, y: 2)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    } else {
                        // Edit Button
                        Button(action: {
                            editedAccountName = password.accountName ?? ""
                            editedUsername = password.username ?? ""
                            editedPassword = PasswordManager.shared.decryptPassword(password)
                            isEditing = true // Start editing
                        }) {
                            Text("Edit")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(30)
                                .shadow(color: .black.opacity(0.15), radius: 2, x: 2, y: 2)
                        }
                        
                        Spacer()
                        
                        // Delete Button
                        Button(action: {
                            showDeleteConfirmation = true // Show confirmation dialog
                        }) {
                            Text("Delete")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(30)
                                .shadow(color: .red.opacity(0.15), radius: 2, x: 2, y: 2)
                        }
                        .alert(isPresented: $showDeleteConfirmation) {
                            Alert(
                                title: Text("Are you sure?"),
                                message: Text("Do you really want to delete this password? This action cannot be undone."),
                                primaryButton: .destructive(Text("Delete")) {
                                    deletePassword()
                                    presentationMode.wrappedValue.dismiss()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    // Function to validate fields before saving
    private func validateFields() {
        if editedAccountName.isEmpty {
            alertMessage = "Please enter an account name."
            showAlert = true
        } else if editedUsername.isEmpty {
            alertMessage = "Please enter a username."
            showAlert = true
        } else if editedPassword.isEmpty {
            alertMessage = "Please enter a password."
            showAlert = true
        } else {
            // All fields are valid, proceed to save
            savePasswordChanges()
            isEditing = false
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // Function to save changes to the entity in Core Data
    private func savePasswordChanges() {
        password.accountName = editedAccountName
        password.username = editedUsername
        password.password = editedPassword
        
        PasswordManager.shared.updatePassword(passwordEntity: password, newAccountName: editedAccountName, newUsername: editedUsername, newPassword: editedPassword)
    }
    
    // Function to delete the password
    private func deletePassword() {
        PasswordManager.shared.deletePassword(passwordEntity: password)
    }
    
    private func maskedPassword(for password: Password) -> String {
        let decryptedPassword = PasswordManager.shared.decryptPassword(password)
        return String(repeating: "*", count: decryptedPassword.count)
    }
}

