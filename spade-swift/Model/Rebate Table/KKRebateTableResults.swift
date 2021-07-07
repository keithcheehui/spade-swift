//
//  KKRebateTableResults.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateTableResults: Codable {

    enum CodingKeys: String, CodingKey {
      case excludedProducts = "bonus_excluded_products"
      case rebates
      case name
      case code
      case id
    }

    var excludedProducts: [KKRebateTableRebateExcludedProducts]?
    var rebates: [KKRebateTableRebateRates]?
      var name: String?
      var code: String?
    var id: Int?



    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      excludedProducts = try container.decodeIfPresent([KKRebateTableRebateExcludedProducts].self, forKey: .excludedProducts)
        rebates = try container.decodeIfPresent([KKRebateTableRebateRates].self, forKey: .rebates)
      name = try container.decodeIfPresent(String.self, forKey: .name)
      code = try container.decodeIfPresent(String.self, forKey: .code)
      id = try container.decodeIfPresent(Int.self, forKey: .id)
    }


}
