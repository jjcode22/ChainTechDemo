//
//  AddPasswordView.swift
//  ChainTechDemo
//
//  Created by JJMac on 18/09/24.
//

import SwiftUI

struct AddPasswordView: View {
    @State private var accountName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Account Name TextField
            TextField("Account Name", text: $accountName)
                .background(Color.white)
                .textFieldStyle(OutlinedTextFieldStyleSmall())
            
            // Username TextField
            TextField("Username", text: $username)
                .background(Color.white)
                .textFieldStyle(OutlinedTextFieldStyleSmall())
            
            // Password Field with Toggle
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                        .background(Color.white)
                        .textFieldStyle(OutlinedTextFieldStyleSmall())
                } else {
                    SecureField("Password", text: $password)
                        .background(Color.white)
                        .textFieldStyle(OutlinedTextFieldStyleSmall())
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
            
            // Password Strength View
            PasswordStrengthView(password: $password)
            
            // Add Account Button
            Button {
                validateFields()
            } label: {
                Text("Add New Account")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.black)
                    .cornerRadius(30)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
        .padding(20)
    }

    // Validation function
    private func validateFields() {
        if accountName.isEmpty {
            alertMessage = "Please enter an account name."
            showAlert = true
        } else if username.isEmpty {
            alertMessage = "Please enter a username."
            showAlert = true
        } else if password.isEmpty {
            alertMessage = "Please enter a password."
            showAlert = true
        } else {
            // All fields are filled, save the password
            PasswordManager.shared.savePassword(accountName: accountName, username: username, password: password)
            presentationMode.wrappedValue.dismiss()
        }
    }
}


