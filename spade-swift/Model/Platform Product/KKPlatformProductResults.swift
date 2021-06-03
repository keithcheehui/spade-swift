//
//  KKPlatformProductResults.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPlatformProductResults: Codable {

  enum CodingKeys: String, CodingKey {
    case products
  }

  var products: [KKPlatformProductDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    products = try container.decodeIfPresent([KKPlatformProductDetails].self, forKey: .products)
  }

}
