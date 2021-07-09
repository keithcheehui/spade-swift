//
//  KKRebateTableRebateExcludedProducts.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKTableExcludedProducts: Codable {

  enum CodingKeys: String, CodingKey {
    case productName = "product_name"
    case platformName = "platform_name"
    case productId = "product_id"
    case platformId = "platform_id"
    case groupId = "group_id"
    case id
  }

    var productName: String?
    var platformName: String?
    var productId: Int?
    var platformId: Int?
    var groupId: Int?
    var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    productName = try container.decodeIfPresent(String.self, forKey: .productName)
    platformName = try container.decodeIfPresent(String.self, forKey: .platformName)
    productId = try container.decodeIfPresent(Int.self, forKey: .productId)
    platformId = try container.decodeIfPresent(Int.self, forKey: .platformId)
    groupId = try container.decodeIfPresent(Int.self, forKey: .groupId)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
