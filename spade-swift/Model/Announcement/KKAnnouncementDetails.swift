//
//  KKAnnouncementAnnouncements.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAnnouncementDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case descriptionValue = "description"
        case title = "title"
        case created_at = "created_at"
    }

    var descriptionValue: String?
    var title: String?
    var created_at: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
    }
}
