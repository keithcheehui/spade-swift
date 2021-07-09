//
//  KKGuidelineDetails.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKGuidelineDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case title
        case content
    }

    var title: String?
    var content: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        content = try container.decodeIfPresent(String.self, forKey: .content)
    }
}
