//
//  KKBonusDetails.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKPromotionDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case button_name = "group_name"
        case items
    }

    var button_name: String?
    var items: [KKPromotionItemDetails]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        button_name = try container.decodeIfPresent(String.self, forKey: .button_name)
        items = try container.decodeIfPresent([KKPromotionItemDetails].self, forKey: .items)
    }
}
