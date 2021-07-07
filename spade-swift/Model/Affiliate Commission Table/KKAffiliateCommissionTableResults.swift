//
//  KKAffiliateCommissionTableResults.swift
//
//  Created by Wong Sai Khong on 08/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateCommissionTableResults: Codable {

  enum CodingKeys: String, CodingKey {
    case excludedProducts = "bonus_excluded_products"
    case name
    case code
    case rebates
    case id
  }

  var excludedProducts: [KKRebateTableRebateExcludedProducts]?
  var name: String?
  var code: String?
  var rebates: [KKAffiliateCommissionTableRebates]?
  var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    excludedProducts = try container.decodeIfPresent([KKRebateTableRebateExcludedProducts].self, forKey: .excludedProducts)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    rebates = try container.decodeIfPresent([KKAffiliateCommissionTableRebates].self, forKey: .rebates)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
