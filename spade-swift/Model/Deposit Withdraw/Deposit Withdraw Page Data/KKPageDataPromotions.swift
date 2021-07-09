//
//  KKPageDataPromotions.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPageDataPromotions: Codable {

  enum CodingKeys: String, CodingKey {
    case endDate = "end_date"
    case name
    case promoCode = "promo_code"
    case startDate = "start_date"
    case amount
    case type
  }

  var endDate: String?
  var name: String?
  var promoCode: String?
  var startDate: String?
  var amount: String?
  var type: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    promoCode = try container.decodeIfPresent(String.self, forKey: .promoCode)
    startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    type = try container.decodeIfPresent(String.self, forKey: .type)
  }

}
