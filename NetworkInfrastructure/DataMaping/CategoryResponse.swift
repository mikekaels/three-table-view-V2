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
    public let categoryAllList: CategoryAllList
}

public struct CategoryAllList: Codable, Equatable {
    public let categories: [CategoryData]
}

public struct CategoryData: Codable, Equatable {
    public let id, name, identifier: String
    public let url: String
    public let iconImageURL: String
    public let iconImageURLGray: String
    public let parentName: String
    public let applinks: String
    public let iconBannerURL: String
    public let child: [CategoryData]?

    enum CodingKeys: String, CodingKey {
        case id, name, identifier, url
        case iconImageURL = "iconImageUrl"
        case iconImageURLGray = "iconImageUrlGray"
        case parentName, applinks, iconBannerURL, child
    }
}

