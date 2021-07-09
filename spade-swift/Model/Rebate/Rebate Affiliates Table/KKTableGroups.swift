//
//  KKRebateTableGroups.swift
//
//  Created by Wong Sai Khong on 09/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKTableGroups: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case id
    case rebates
    case name
    case excludedProducts = "bonus_excluded_products"
  }

  var code: String?
  var id: Int?
  var rebates: [KKTableRebates]?
  var name: String?
  var excludedProducts: [KKTableExcludedProducts]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    rebates = try container.decodeIfPresent([KKTableRebates].self, forKey: .rebates)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    excludedProducts = try container.decodeIfPresent([KKTableExcludedProducts].self, forKey: .excludedProducts)
  }

}
