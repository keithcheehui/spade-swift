//
//  KKWithdrawBankBankNames.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKWithdrawBankNames: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case id
    case img
  }
    
    var name: String?
    var id: Int?
    var img: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    img = try container.decodeIfPresent(String.self, forKey: .img)
  }

}
