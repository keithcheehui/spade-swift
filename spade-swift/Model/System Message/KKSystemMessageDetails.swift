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
        case updated_at
    }

    var title: String?
    var content: String?
    var updated_at: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }
}
