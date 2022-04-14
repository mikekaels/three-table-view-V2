//
//  UserDefaultManager.swift
//  Core
//
//  Created by Santo Michael Sihombing on 14/04/22.
//

import Foundation

public class UserDefaultsManager {

    public static let shared = UserDefaultsManager()

    public func saveCategory(value: String) {
        UserDefaults.standard.set(value, forKey: "category")
    }
    
    public func getCategory() -> String {
        return UserDefaults.standard.string(forKey: "category") ?? ""
    }
}
