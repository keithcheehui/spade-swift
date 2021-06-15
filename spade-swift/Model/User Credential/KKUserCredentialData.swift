//
//  KKData.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCredentialData: Codable {

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
  }

  var accessToken: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
  }
}
