//
//  KKAnnouncementResults.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAnnouncementResults: Codable {

  enum CodingKeys: String, CodingKey {
    case announcements
  }

  var announcements: [KKAnnouncementDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    announcements = try container.decodeIfPresent([KKAnnouncementDetails].self, forKey: .announcements)
  }

}
