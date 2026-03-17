//
//  PixelAPIModel.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import Foundation

struct PixelAPIModel: Codable {
    let hits: [Post]
}


struct Post: Identifiable, Codable {
    let id: Int
    let author: String
    let authorImageURL: String
    let previewImageURL: String
    let mediumSizeImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author = "user"
        case authorImageURL = "userImageURL"
        case previewImageURL = "previewURL"
        case mediumSizeImageURL = "webformatURL"
    }
}

