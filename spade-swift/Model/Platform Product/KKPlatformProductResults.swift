//
//  KKPlatformProductResults.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKPlatformProductResults: Codable {

    enum CodingKeys: String, CodingKey {
      case gameTypeListing = "game_type_listing"
    }

    var gameTypeListing: [KKGameTypeListing]?

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      gameTypeListing = try container.decodeIfPresent([KKGameTypeListing].self, forKey: .gameTypeListing)
    }
}
