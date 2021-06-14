//
//  KKGroupPlatformPlatforms.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKGroupPlatformDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case img
        case code
        case type
    }

    var name: String?
    var img: String?
    var code: String?
    var type: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        img = try container.decodeIfPresent(String.self, forKey: .img)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        type = try container.decodeIfPresent(String.self, forKey: .type)
    }
}
