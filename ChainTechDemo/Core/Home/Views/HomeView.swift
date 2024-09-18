//
//  HomeView.swift
//  ChainTechDemo
//
//  Created by JJMac on 17/09/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password Manager 🔑")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    Divider()
                        .opacity(0.6)
                }
                .padding(.top)
                
                // Password List
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.passwords, id: \.self) { password in
                            Button(action: {
                                viewModel.selectPassword(password)
                            }) {
                                HStack(alignment: .center) {
                                    Text(password.accountName ?? "Unknown")
                                        .font(.title2)
                                        .padding()
                                        .bold()
                                    Text("\(viewModel.maskPassword(password))")
                                        .opacity(0.4)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .padding()
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                                )
                                .foregroundStyle(Color.black)
                                .background(Color.white)
                                .cornerRadius(40)
                                .padding()
                            }
                        }
                        .shadow(color: .gray.opacity(0.15), radius: 2, x: 2, y: 2)
                    }
                }
            }
            .background(Color(hex: "#F3F5FA"))
            
            // Add Password Button
            VStack {
                Spacer() // Pushes the button to the bottom
                HStack {
                    Spacer()
                    Button {
                        viewModel.addNewPassword()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(Color(hex: "#3F7DE3"))
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2, y: 2)
                    }
                    .padding(.trailing) // Aligns the button to the right
                }
                .padding(.bottom, 30) // Adds 30 padding from the bottom
            }
            .padding(.horizontal)
        }
        // Sheet for Adding Password
        .sheet(isPresented: $viewModel.showAddScreen) {
            AddPasswordView()
                .background(Color(hex: "#F3F5FA"))
                .presentationDetents([.medium, .fraction(0.7)])
                .presentationDragIndicator(.visible)
                .onDisappear {
                    viewModel.closeAddPasswordScreen()
                }
        }
        // Sheet for Password Details
        .sheet(item: $viewModel.selectedPassword) { password in
            PasswordDetailView(password: password)
                .background(Color(hex: "#F9F9F9"))
                .presentationDetents([.medium, .fraction(0.7)])
                .presentationDragIndicator(.visible)
                .onDisappear {
                    viewModel.closePasswordDetailScreen()
                }
        }
    }
}


#Preview {
    HomeView()
}










//struct PasswordDetailView: View {
//    @State private var isPasswordHidden: Bool = true
//    var password: Password
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Spacer()
//            
//            VStack(alignment: .leading, spacing: 10) {
//                Text("Account Details")
//                    .font(.title2)
//                    .bold()
//                    .foregroundColor(Color.blue)
//                    .padding(.bottom)
//                
//                VStack(alignment: .leading) {
//                    Text("Account Type")
//                        .font(.subheadline)
//                        .foregroundStyle(Color.gray.opacity(0.7))
//                        .bold()
//                    Text(password.accountName ?? "Unknown")
//                        .font(.title3)
//                        .bold()
//                }
//                
//                VStack(alignment: .leading) {
//                    Text("Username/Email")
//                        .font(.subheadline)
//                        .foregroundStyle(Color.gray.opacity(0.7))
//                        .bold()
//                    Text(password.username ?? "Unknown")
//                        .font(.title3)
//                        .bold()
//                }
//                
//                VStack(alignment: .leading) {
//                    Text("Password")
//                        .font(.subheadline)
//                        .foregroundStyle(Color.gray.opacity(0.7))
//                        .bold()
//                    HStack {
//                        Text(isPasswordHidden ? maskedPassword(for: password) : PasswordManager.shared.decryptPassword(password))
//                            .font(.title3)
//                            .bold()
//                        Spacer()
//                        Button(action: {
//                            isPasswordHidden.toggle()
//                        }) {
//                            Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
//                                .foregroundColor(.gray)
//                        }
////                        .padding(.trailing,40)
//                    }
//                    Spacer()
//                    
//                    HStack(spacing: 8) {
//                        Button(action: {
//                            // Edit action here
//                        }) {
//                            Text("Edit")
//                                .bold()
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.black)
//                                .cornerRadius(30)
//                                .shadow(color: .black.opacity(0.15), radius: 2, x: 2, y: 2)
//                        }
//                        Spacer()
//                        
//                        Button(action: {
//                            // Delete action here
//                        }) {
//                            Text("Delete")
//                                .bold()
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.red)
//                                .cornerRadius(30)
//                                .shadow(color: .red.opacity(0.15), radius: 2, x: 2, y: 2)
//                        }
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//    
//    private func maskedPassword(for password: Password) -> String {
//        let decryptedPassword = PasswordManager.shared.decryptPassword(password)
//        return String(repeating: "*", count: decryptedPassword.count)
//    }
//}
                       

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}

struct OutlinedTextFieldStyleSmall: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal)
            .padding(.vertical,8)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}





