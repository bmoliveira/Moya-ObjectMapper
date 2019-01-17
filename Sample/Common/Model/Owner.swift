//
//  Owner.swift
//  Demo
//
//  Created by Ivan Bruel on 28/06/16.
//  Copyright © 2016 Ash Furrow. All rights reserved.
//

import Foundation
import ObjectMapper

class Owner: ImmutableMappable {

  let id: Int
  let organizationsURL: String
  let receivedEventsURL: String
  let followingURL: String
  let login: String
  let avatarURL: String
  let URL: String
  let subscriptionsURL: String
  let type: String
  let reposURL: String
  let htmlURL: String
  let eventsURL: String
  let siteAdmin: Bool
  let starredURL: String
  let gistsURL: String
  let gravatarId: String
  let followersURL: String

  required init(map: Map) throws {
    id = try map.value("id")
    organizationsURL = try map.value("organizations_url")
    receivedEventsURL = try map.value("received_events_url")
    followingURL = try map.value("following_url")
    login = try map.value("login")
    avatarURL = try map.value("avatar_url")
    URL = try map.value("url")
    subscriptionsURL = try map.value("subscriptions_url")
    type = try map.value("type")
    reposURL = try map.value("repos_url")
    htmlURL = try map.value("html_url")
    eventsURL = try map.value("events_url")
    siteAdmin = try map.value("site_admin")
    starredURL = try map.value("starred_url")
    gistsURL = try map.value("gists_url")
    gravatarId = try map.value("gravatar_id")
    followersURL = try map.value("followers_url")
  }

}
