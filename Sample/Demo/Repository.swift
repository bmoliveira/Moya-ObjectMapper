//
//  Repository.swift
//  Demo
//
//  Created by Ivan Bruel on 28/06/16.
//  Copyright © 2016 Ash Furrow. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repository: Mappable {

  var keysURL: String!
  var statusesURL: String!
  var issuesURL: String!
  var defaultBranch: String!
  var issueEventsURL: String!
  var id: Int!
  var owner: Owner!
  var eventsURL: String!
  var subscriptionURL: String!
  var watchers: Int!
  var gitCommitsURL: String!
  var subscribersURL: String!
  var cloneURL: String!
  var hasWiki: Bool!
  var URL: String!
  var pullsURL: String!
  var fork: Bool!
  var notificationsURL: String!
  var description: String!
  var collaboratorsURL: String!
  var deploymentsURL: String!
  var languagesURL: String!
  var hasIssues: Bool!
  var commentsURL: String!
  var isPrivate: Bool!
  var size: Int!
  var gitTagsURL: String!
  var updatedAt: String!
  var sshURL: String!
  var name: String!
  var contentsURL: String!
  var archiveURL: String!
  var milestonesURL: String!
  var blobsURL: String!
  var contributorsURL: String!
  var openIssuesCount: Int!
  var forksCount: Int!
  var treesURL: String!
  var svnURL: String!
  var commitsURL: String!
  var createdAt: String!
  var forksURL: String!
  var hasDownloads: Bool!
  var mirrorURL: String?
  var homepage: String!
  var teamsURL: String!
  var branchesURL: String!
  var issueCommentURL: String!
  var mergesURL: String!
  var gitRefsURL: String!
  var gitURL: String!
  var forks: Int!
  var openIssues: Int!
  var hooksURL: String!
  var htmlURL: String!
  var stargazersURL: String!
  var assigneesURL: String!
  var compareURL: String!
  var fullName: String!
  var tagsURL: String!
  var releasesURL: String!
  var pushedAt: String?
  var labelsURL: String!
  var downloadsURL: String!
  var stargazersCount: Int!
  var watchersCount: Int!
  var language: String!
  var hasPages: Bool!

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    keysURL <- map["keys_url"]
    statusesURL <- map["statuses_url"]
    issuesURL <- map["issues_url"]
    defaultBranch <- map["default_branch"]
    issueEventsURL <- map["issues_events_url"]
    id <- map["id"]
    owner <- map["owner"]
    eventsURL <- map["events_url"]
    subscriptionURL <- map["subscription_url"]
    watchers <- map["watchers"]
    gitCommitsURL <- map["git_commits_url"]
    subscribersURL <- map["subscribers_url"]
    cloneURL <- map["clone_url"]
    hasWiki <- map["has_wiki"]
    URL <- map["url"]
    pullsURL <- map["pulls_url"]
    fork <- map["fork"]
    notificationsURL <- map["notifications_url"]
    description <- map["description"]
    collaboratorsURL <- map["collaborators_url"]
    deploymentsURL <- map["deployments_url"]
    languagesURL <- map["languages_url"]
    hasIssues <- map["has_issues"]
    commentsURL <- map["comments_url"]
    isPrivate <- map["private"]
    size <- map["size"]
    gitTagsURL <- map["git_tags_url"]
    updatedAt <- map["updated_at"]
    sshURL <- map["ssh_url"]
    name <- map["name"]
    contentsURL <- map["contents_url"]
    archiveURL <- map["archive_url"]
    milestonesURL <- map["milestones_url"]
    blobsURL <- map["blobs_url"]
    contributorsURL <- map["contributors_url"]
    openIssuesCount <- map["open_issues_count"]
    forksCount <- map["forks_count"]
    treesURL <- map["trees_url"]
    svnURL <- map["svn_url"]
    commitsURL <- map["commits_url"]
    createdAt <- map["created_at"]
    forksURL <- map["forks_url"]
    hasDownloads <- map["has_downloads"]
    mirrorURL <- map["mirror_url"]
    homepage <- map["homepage"]
    teamsURL <- map["teams_url"]
    branchesURL <- map["branches_url"]
    issueCommentURL <- map["issue_comment_url"]
    mergesURL <- map["merges_url"]
    gitRefsURL <- map["git_refs_url"]
    gitURL <- map["git_url"]
    forks <- map["forks"]
    openIssues <- map["open_issues"]
    hooksURL <- map["hooks_url"]
    htmlURL <- map["html_url"]
    stargazersURL <- map["stargazers_url"]
    assigneesURL <- map["assignees_url"]
    compareURL <- map["compare_url"]
    fullName <- map["full_name"]
    tagsURL <- map["tags_url"]
    releasesURL <- map["releases_url"]
    pushedAt <- map["pushed_at"]
    labelsURL <- map["labels_url"]
    downloadsURL <- map["downloads_url"]
    stargazersCount <- map["stargazers_count"]
    watchersCount <- map["watchers_count"]
    language <- map["language"]
    hasPages <- map["has_pages"]
  }


}
