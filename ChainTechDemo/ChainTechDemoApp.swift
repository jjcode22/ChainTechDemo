//
//  ChainTechDemoApp.swift
//  ChainTechDemo
//
//  Created by JJMac on 17/09/24.
//

import SwiftUI

@main
struct ChainTechDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
