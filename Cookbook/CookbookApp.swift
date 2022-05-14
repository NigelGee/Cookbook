//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Nigel Gee on 14/05/2022.
//

import SwiftUI

@main
struct CookbookApp: App {
    @StateObject var menus: ViewModel

    /// init required for @MainActor do push UI changes to main thread
    init() {
        self._menus = StateObject(wrappedValue: ViewModel())
    }

    var body: some Scene {
        WindowGroup {
            ContentView(vm: menus)
                .task { await menus.fetch() }
        }

    }
}
