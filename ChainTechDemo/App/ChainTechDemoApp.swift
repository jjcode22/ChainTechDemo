//
//  ChainTechDemoApp.swift
//  ChainTechDemo
//
//  Created by JJMac on 17/09/24.
//
import SwiftUI
import LocalAuthentication

@main
struct ChainTechDemoApp: App {
    let persistenceController = PersistenceController.shared
    @State private var isAuthenticated = false

    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                HomeView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                Color.white
                    .onAppear {
                        #if targetEnvironment(simulator)
                        // If running on the simulator, skip authentication
                        isAuthenticated = true
                        #else
                        // Otherwise, proceed with normal authentication
                        authenticateUser()
                        #endif
                    }
            }
        }
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        // Check if Face ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate using Face ID or Touch ID to access the app"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Face ID Authentication succeeded
                        isAuthenticated = true
                    } else {
                        // Fallback to passcode authentication
                        authenticateUsingPasscode(context: context)
                    }
                }
            }
        } else {
            // If biometrics aren't available, fallback to passcode immediately
            authenticateUsingPasscode(context: context)
        }
    }
    
    func authenticateUsingPasscode(context: LAContext) {
        let reason = "Please authenticate using your passcode to access the app"

        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
            DispatchQueue.main.async {
                if success {
                    // Passcode authentication succeeded
                    isAuthenticated = true
                } else {
                    // Authentication failed
                    isAuthenticated = false
                }
            }
        }
    }
}
