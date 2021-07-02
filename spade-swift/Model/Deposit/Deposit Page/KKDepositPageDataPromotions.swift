//
//  KKDepositPageDataPromotions.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositPageDataPromotions: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case amount
    case type
    case endDate = "end_date"
    case promoCode = "promo_code"
    case startDate = "start_date"
  }

  var name: String?
  var amount: String?
  var type: String?
  var endDate: String?
  var promoCode: String?
  var startDate: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    amount = try container.decodeIfPresent(String.self, forKey: .amount)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
    promoCode = try container.decodeIfPresent(String.self, forKey: .promoCode)
    startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
  }

}
