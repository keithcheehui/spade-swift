//
//  KKAppVersionResults.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAppVersionResults: Codable {

  enum CodingKeys: String, CodingKey {
    case appVersion
    case languages
    case countries
  }

  var appVersion: KKAppVersionAppVersion?
  var languages: [KKAppVersionLanguages]?
  var countries: [KKAppVersionCountries]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    appVersion = try container.decodeIfPresent(KKAppVersionAppVersion.self, forKey: .appVersion)
    languages = try container.decodeIfPresent([KKAppVersionLanguages].self, forKey: .languages)
    countries = try container.decodeIfPresent([KKAppVersionCountries].self, forKey: .countries)
  }

}
