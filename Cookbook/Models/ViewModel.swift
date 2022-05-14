//
//  ViewModel.swift
//  Test
//
//  Created by Nigel Gee on 14/05/2022.
//

import Foundation

@MainActor
final class ViewModel: ObservableObject {
    @Published var menus = [Menu]()

    @Published var menu = MenuSelection.all
    @Published var selectedFilter = FilterSelection.all

    private var menuType: [Recipe] {
        if menu == .all {
            return menus.flatMap { $0.recipes }
        } else {
            let selectedMenu = menus.filter { $0.type == menu.rawValue.capitalized }
            return selectedMenu.flatMap { $0.recipes }
        }
    }

    var filteredRecipes: [Recipe] {
        if selectedFilter == .all {
            return menuType
        } else {
            guard let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date.now) else {
                fatalError("Unable to get next day from date")
            }
            return menuType.filter { $0.dateCreated >= weekAgo }
        }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            let userURL = URL(string: "https://recipesstore.s3.eu-west-2.amazonaws.com/Menu.json")!
            // added `dateDecodingStrategy` as there is an ISO8601 date in JSON but not always required.
            async let userItems = try await URLSession.shared.decode([Menu].self, from: userURL, dateDecodingStrategy: .iso8601)
            menus = try await userItems
        } catch {
            print("Failed to fetch data!")
            // This is because the URL does not exist and using JSON in bundle
            self.menus = Bundle.main.decode([Menu].self, from: "menus.json", dateDecodingStrategy: .iso8601)
        }
    }
}
