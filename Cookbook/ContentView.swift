//
//  ContentView.swift
//  Cookbook
//
//  Created by Nigel Gee on 14/05/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: ViewModel

    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("Select menu", selection: $vm.selectedMenu) {
                        ForEach(MenuSelection.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }

                    Picker("Select time", selection: $vm.selectedFilter) {
                        ForEach(FilterSelection.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                ForEach(vm.filteredRecipes) { recipe in
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                        Text(recipe.creator)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ViewModel())
    }
}
