//
//  CategoryResponse.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 11/04/22.
//

import Foundation


public struct CategoryResponse: Codable, Equatable {
    public let data: Data
}

public struct Data: Codable, Equatable {
    public let categories: [CategoryData]
}

//public struct CategoryAllList: Codable, Equatable {
//    public let categories: [CategoryData]
//}

public struct CategoryData: Codable, Equatable {
    public let id, name, identifier: String
    public let url: String
    public let isAdult: Int
    public let iconImageURL: String
    public let tree, hidden: Int
    public let isRevamp, isIntermediary: Bool
    public let applinks: String
    public let rootCategoryID: Int
    public let child: [CategoryData]?
    public let isFreeReturn: Bool
    public let redirectionURL: String
    public let iconImageURLGray, iconBanner: String
    public let rgbColor: String
    public let isKyc: Bool
    public let minAge: Int
    public let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, identifier, url
        case isAdult = "is_adult"
        case iconImageURL = "icon_image_url"
        case tree, hidden
        case isRevamp = "is_revamp"
        case isIntermediary = "is_intermediary"
        case applinks
        case rootCategoryID = "root_category_id"
        case child
        case isFreeReturn = "is_free_return"
        case redirectionURL = "redirection_url"
        case iconImageURLGray = "icon_image_url_gray"
        case iconBanner = "icon_banner"
        case rgbColor = "rgb_color"
        case isKyc = "is_kyc"
        case minAge = "min_age"
        case weight
    }
}

