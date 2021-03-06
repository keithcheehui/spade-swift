//
//  KKRebateTableRebateTable.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateTableRebateTable: Codable {

  enum CodingKeys: String, CodingKey {
    case excludedProducts = "bonus_exluded_products"
    case rebateRates = "rebates"
    case name
    case code
    case id
  }

  var excludedProducts: [KKRebateTableRebateExcludedProducts]?
  var rebateRates: [KKRebateTableRebateRates]?
    var name: String?
    var code: String?
  var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    excludedProducts = try container.decodeIfPresent([KKRebateTableRebateExcludedProducts].self, forKey: .excludedProducts)
    rebateRates = try container.decodeIfPresent([KKRebateTableRebateRates].self, forKey: .rebateRates)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
