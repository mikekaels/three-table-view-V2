//
//  UserDefaultManager.swift
//  Core
//
//  Created by Santo Michael Sihombing on 14/04/22.
//

import Foundation

public class UserDefaultsManager {

    public static let shared = UserDefaultsManager()

    public func saveDefault(value: String, type: defaultType) {
        UserDefaults.standard.set(value, forKey: type.rawValue)
    }
    
    public func getDefault(type: defaultType) -> String {
        return UserDefaults.standard.string(forKey: type.rawValue) ?? ""
    }
    
    public enum defaultType: String {
        case category = "category"
        case image = "image"
    }
}
