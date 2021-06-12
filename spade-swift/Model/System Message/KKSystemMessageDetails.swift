//
//  KKSystemMessageDetails.swift
//
//  Created by Keith CheeHui on 09/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKSystemMessageDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case title
        case content
        case created_at
    }

    var title: String?
    var content: String?
    var created_at: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
    }
}
