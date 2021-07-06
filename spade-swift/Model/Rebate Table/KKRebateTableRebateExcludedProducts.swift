//
//  KKRebateTableRebateExcludedProducts.swift
//
//  Created by Wong Sai Khong on 06/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKRebateTableRebateExcludedProducts: Codable {

  enum CodingKeys: String, CodingKey {
    case productName = "product_name"
    case platformName = "platform_name"
  }

  var productName: String?
  var platformName: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    productName = try container.decodeIfPresent(String.self, forKey: .productName)
    platformName = try container.decodeIfPresent(String.self, forKey: .platformName)
  }

}
