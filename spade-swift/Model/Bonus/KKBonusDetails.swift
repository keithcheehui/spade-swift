//
//  KKBonusDetails.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKBonusDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case img
        case button_name
        case content
    }

    var img: String?
    var button_name: String?
    var content: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        img = try container.decodeIfPresent(String.self, forKey: .img)
        button_name = try container.decodeIfPresent(String.self, forKey: .button_name)
        content = try container.decodeIfPresent(String.self, forKey: .content)
    }
}
