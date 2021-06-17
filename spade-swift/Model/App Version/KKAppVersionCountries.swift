//
//  KKAppVersionCountries.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAppVersionCountries: Codable {

  enum CodingKeys: String, CodingKey {
    case currency
    case img
    case name
    case currencyName = "currency_name"
    case code
    case countryPrefix = "country_calling_code"
  }

  var currency: String?
  var img: String?
  var name: String?
  var currencyName: String?
  var code: String?
  var countryPrefix: String?


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    currency = try container.decodeIfPresent(String.self, forKey: .currency)
    img = try container.decodeIfPresent(String.self, forKey: .img)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    currencyName = try container.decodeIfPresent(String.self, forKey: .currencyName)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    countryPrefix = try container.decodeIfPresent(String.self, forKey: .countryPrefix)
  }

}
