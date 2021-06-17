//
//  KKDepositBankDepositChannels.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositBankDepositChannels: Codable {

  enum CodingKeys: String, CodingKey {
    case max
    case min
    case code
    case name
  }

  var max: String?
  var min: String?
  var code: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    max = try container.decodeIfPresent(String.self, forKey: .max)
    min = try container.decodeIfPresent(String.self, forKey: .min)
    code = try container.decodeIfPresent(String.self, forKey: .code)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
