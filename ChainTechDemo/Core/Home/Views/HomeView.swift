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







