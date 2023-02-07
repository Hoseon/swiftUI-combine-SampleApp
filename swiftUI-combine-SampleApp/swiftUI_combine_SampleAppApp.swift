//
//  swiftUI_combine_SampleAppApp.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

@main
struct swiftUI_combine_SampleAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
