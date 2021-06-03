//
//  KKAppVersionAppVersion.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAppVersionAppVersion: Codable {

  enum CodingKeys: String, CodingKey {
    case bundleId = "bundle_id"
    case status
    case downloadUrl = "download_url"
    case platform
    case appVersion = "app_version"
    case isLatest
    case appName = "app_name"
  }

  var bundleId: String?
  var status: String?
  var downloadUrl: String?
  var platform: String?
  var appVersion: String?
  var isLatest: Bool?
  var appName: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bundleId = try container.decodeIfPresent(String.self, forKey: .bundleId)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    downloadUrl = try container.decodeIfPresent(String.self, forKey: .downloadUrl)
    platform = try container.decodeIfPresent(String.self, forKey: .platform)
    appVersion = try container.decodeIfPresent(String.self, forKey: .appVersion)
    isLatest = try container.decodeIfPresent(Bool.self, forKey: .isLatest)
    appName = try container.decodeIfPresent(String.self, forKey: .appName)
  }

}
