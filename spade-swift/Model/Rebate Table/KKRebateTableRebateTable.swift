//
//  KKRebateTableRebateTable.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateTableRebateTable: Codable {

  enum CodingKeys: String, CodingKey {
    case excludedProducts = "excluded_products"
    case rebateRates = "rebate_rates"
    case name
    case groupId = "group_id"
  }

  var excludedProducts: [KKRebateTableRebateExcludedProducts]?
  var rebateRates: [KKRebateTableRebateRates]?
  var name: String?
  var groupId: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    excludedProducts = try container.decodeIfPresent([KKRebateTableRebateExcludedProducts].self, forKey: .excludedProducts)
    rebateRates = try container.decodeIfPresent([KKRebateTableRebateRates].self, forKey: .rebateRates)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    groupId = try container.decodeIfPresent(Int.self, forKey: .groupId)
  }

}
