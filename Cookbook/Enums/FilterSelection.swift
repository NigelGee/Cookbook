//
//  FilterSelection.swift
//  Cookbook
//
//  Created by Nigel Gee on 14/05/2022.
//

import Foundation

/// To determine if all the menu items should be show or just the newest
enum FilterSelection: String, CaseIterable {
    case all, latest
}
