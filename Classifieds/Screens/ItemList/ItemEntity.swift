//
//  ItemEntity.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import Foundation

struct ItemResponse: Codable {
    var results: [Item]?
}

struct Item: Codable {
    let name: String
    let uid: String
    let price: String
    let createdAt: String
    let imageIds: [String]
    let imageUrls: [String]
    let imageUrlsThumbnails: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, uid, price
        case createdAt = "created_at"
        case imageIds = "image_ids"
        case imageUrls = "image_urls"
        case imageUrlsThumbnails = "image_urls_thumbnails"
    }
}

