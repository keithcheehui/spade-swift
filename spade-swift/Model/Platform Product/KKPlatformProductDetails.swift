//
//  KKPlatformProductProducts.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPlatformProductDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case code
        case platform
        case groupCode = "group_code"
        case platformCode = "platform_code"
        case img
    }
  
    var name: String?
    var code: String?
    var platform: String?
    var groupCode: String?
    var platformCode: String?
    var img: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        platform = try container.decodeIfPresent(String.self, forKey: .platform)
        groupCode = try container.decodeIfPresent(String.self, forKey: .groupCode)
        platformCode = try container.decodeIfPresent(String.self, forKey: .platformCode)
        img = try container.decodeIfPresent(String.self, forKey: .img)
    }
}
