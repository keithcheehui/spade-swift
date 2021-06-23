//
//  KKPromotionItemDetails.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 23/06/2021.
//

import Foundation

struct KKPromotionItemDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case img
        case type
        case status
        case updatedAt = "updated_at"
        case htmlContent
    }

    var img: String?
    var type: String?
    var status: String?
    var updatedAt: String?
    var htmlContent: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        img = try container.decodeIfPresent(String.self, forKey: .img)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        htmlContent = try container.decodeIfPresent(String.self, forKey: .htmlContent)
    }
}
