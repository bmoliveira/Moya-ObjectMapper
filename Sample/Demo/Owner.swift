//
//  Owner.swift
//  Demo
//
//  Created by Ivan Bruel on 28/06/16.
//  Copyright © 2016 Ash Furrow. All rights reserved.
//

import Foundation
import ObjectMapper

class Owner: Mappable {

  var id: Int!
  var organizationsURL: String!
  var receivedEventsURL: String!
  var followingURL: String!
  var login: String!
  var avatarURL: String!
  var URL: String!
  var subscriptionsURL: String!
  var type: String!
  var reposURL: String!
  var htmlURL: String!
  var eventsURL: String!
  var siteAdmin: Bool!
  var starredURL: String!
  var gistsURL: String!
  var gravatarId: String!
  var followersURL: String!

  required init?(_ map: Map) { }

  func mapping(map: Map) {
    id <- map["id"]
    organizationsURL <- map["organizations_url"]
    receivedEventsURL <- map["received_events_url"]
    followingURL <- map["following_url"]
    login <- map["login"]
    avatarURL <- map["avatar_url"]
    URL <- map["url"]
    subscriptionsURL <- map["subscriptions_url"]
    type <- map["type"]
    reposURL <- map["repos_url"]
    htmlURL <- map["html_url"]
    eventsURL <- map["events_url"]
    siteAdmin <- map["site_admin"]
    starredURL <- map["starred_url"]
    gistsURL <- map["gists_url"]
    gravatarId <- map["gravatar_id"]
    followersURL <- map["followers_url"]
  }

}