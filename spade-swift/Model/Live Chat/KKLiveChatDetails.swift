//
//  KKLiveChatDetails.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKLiveChatDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case platform
        case contact_no
        case img
        case redirect_link
    }

    var name: String?
    var platform: String?
    var contact_no: String?
    var img: String?
    var redirect_link: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        platform = try container.decodeIfPresent(String.self, forKey: .platform)
        contact_no = try container.decodeIfPresent(String.self, forKey: .contact_no)
        img = try container.decodeIfPresent(String.self, forKey: .img)
        redirect_link = try container.decodeIfPresent(String.self, forKey: .redirect_link)
    }
}
