
# ChainTechDemo - Password Manager

## gist: https://gist.github.com/dharmveersinh-ixfi/7a5eaac50ddb24853af9fbfcd878971f
## Time/Duration to complete: 1 Day

## Overview
This application is a secure and user-friendly password manager that allows users to store, manage, and protect their passwords. The app encrypts user data, providing secure local storage for account credentials, and offers an intuitive interface for easy access and management.
NOTE: (iOS hides SecureField Text and Keyboard while screen recording)
## Features
- **Add Password**: Store new account details with encrypted passwords.
- https://github.com/user-attachments/assets/c7fec710-9ca3-4f44-9b2d-e0a6f4c7408a
- **View/Edit Password**: Access and modify saved passwords.
- https://github.com/user-attachments/assets/ed93e848-571a-462f-8ee2-9c3dad0c1c96
- **Delete Password**: Securely remove account information.
- https://github.com/user-attachments/assets/ac5de0a3-429d-454d-990a-400db429e91b
- **Password List**: Display stored passwords on the home screen.
- https://github.com/user-attachments/assets/672fe00f-8094-4f7f-9edd-de21e6ccdc76


## Technical Implementation
- **Encryption**: Uses Advanced Encryption Standard (AES-128) encryption for secure password storage using CommonCrypto Framework.
- **Database**: Uses Core Data to handle local storage of encrypted password data.
- **UI**: Simple and clean interface for easy navigation and management using SwiftUI and MVVM.
- **Validation**: Ensures fields are filled before saving or updating data.
- https://github.com/user-attachments/assets/93426967-3f06-42f9-a670-f47dddb09bdb
- **Error Handling**: Graceful management of errors and edge cases.

## Optional Features
- **Biometric Authentication**: Option to unlock the app using fingerprint/face recognition.
- https://github.com/user-attachments/assets/16a7ed52-4381-4d33-bed4-229f1fa75963
- **Password Strength Meter**: Helps users create stronger passwords with a visual strength indicator.
- **Password Generation**: Generates secure, random passwords for user accounts.
- https://github.com/user-attachments/assets/79bab237-6279-405b-b2a7-e6945aba96c3
- **Empty State**: When user opens first time and no password has been saved yet.
- <img width="412" alt="Screenshot 2024-09-18 at 1 59 08 PM" src="https://github.com/user-attachments/assets/c2f2545e-16bd-4503-abd7-a7d585a54f1c">


## How to Run
1. Clone this repository:  
   ```bash
   git clone https://github.com/jjcode22/ChainTechDemo.git
2. Build and run on simulator (or on device for face ID and passcode auth)
