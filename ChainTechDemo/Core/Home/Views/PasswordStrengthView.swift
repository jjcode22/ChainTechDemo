//
//  PasswordStrengthView.swift
//  ChainTechDemo
//
//  Created by JJMac on 18/09/24.
//

import SwiftUI

struct PasswordStrengthView: View {
    @Binding var password: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .lastTextBaseline) {
                Text("Password Strength")
                    .font(.headline)
                    .padding(.top)
                Spacer()
                // Generate Password Button
                Button(action: {
                    password = generatePassword()
                }) {
                    Text("Generate Password 🪄")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.black.opacity(0.7))
                }
            }
            
            // Password Strength Bar
            ProgressView(value: strengthProgress(), total: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: strengthColor()))
                .frame(height: 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(4)
            
            // Password Strength Feedback Text
            Text(strengthFeedback())
                .font(.caption)
                .foregroundColor(strengthColor())
                .padding(.top, 4)
            
            
        }
    }
    
    // Function to calculate progress based on password strength
    private func strengthProgress() -> Double {
        let length = password.count
        
        if length == 0 {
            return 0.0
        } else if length < 6 {
            return 0.25
        } else if isStrongStrength() {
            return 1.0
        } else if isMediumStrength() {
            return 0.75
        } else {
            return 0.5 // Weak password after minimum length
        }
    }
    
    // Function to determine strength feedback
    private func strengthFeedback() -> String {
        let length = password.count
        
        if length == 0 {
            return "Password cannot be empty"
        } else if length < 6 {
            return "Minimum 6 characters required"
        } else if isStrongStrength() {
            return "Strong password"
        } else if isMediumStrength() {
            return "Password is okay"
        } else {
            return "Weak password"
        }
    }
    
    // Function to determine strength color
    private func strengthColor() -> Color {
        let length = password.count
        
        if length == 0 {
            return .gray
        } else if length < 6 {
            return .red
        } else if isStrongStrength() {
            return .green
        } else if isMediumStrength() {
            return .yellow
        } else {
            return .orange
        }
    }
    
    // Check if password is medium strength
    private func isMediumStrength() -> Bool {
        let length = password.count
        let hasLetters = password.range(of: "[a-zA-Z]", options: .regularExpression) != nil
        let hasNumbers = password.range(of: "[0-9]", options: .regularExpression) != nil
        
        return length >= 6 && hasLetters && hasNumbers
    }
    
    // Check if password is strong
    private func isStrongStrength() -> Bool {
        let length = password.count
        let hasLetters = password.range(of: "[a-zA-Z]", options: .regularExpression) != nil
        let hasNumbers = password.range(of: "[0-9]", options: .regularExpression) != nil
        let hasSpecial = password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil
        
        return length >= 8 && hasLetters && hasNumbers && hasSpecial
    }
    
    // Function to generate a strong random password
    private func generatePassword() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        let specialCharacters = "!@#$%^&*(),.<>?[]{}|"
        
        let allCharacters = letters + numbers + specialCharacters
        let length = 12
        
        var password = ""
        
        // Ensure the password contains at least one letter, one number, and one special character
        password.append(letters.randomElement()!)
        password.append(numbers.randomElement()!)
        password.append(specialCharacters.randomElement()!)
        
        // Fill the rest of the password with random characters
        while password.count < length {
            password.append(allCharacters.randomElement()!)
        }
        
        return String(password.shuffled()) // Shuffle to randomize the order
    }
}


