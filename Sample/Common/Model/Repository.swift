//
//  Repository.swift
//  Demo
//
//  Created by Ivan Bruel on 28/06/16.
//  Copyright © 2016 Ash Furrow. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repository: ImmutableMappable {
  var keysURL: String
  var statusesURL: String
  var issuesURL: String
  var defaultBranch: String
  var issueEventsURL: String?
  var id: Int
  var owner: Owner
  var eventsURL: String
  var subscriptionURL: String
  var watchers: Int
  var gitCommitsURL: String
  var subscribersURL: String
  var cloneURL: String
  var hasWiki: Bool
  var URL: String
  var pullsURL: String
  var fork: Bool
  var notificationsURL: String
  var description: String
  var collaboratorsURL: String
  var deploymentsURL: String
  var languagesURL: String
  var hasIssues: Bool
  var commentsURL: String
  var isPrivate: Bool
  var size: Int
  var gitTagsURL: String
  var updatedAt: String
  var sshURL: String
  var name: String
  var contentsURL: String
  var archiveURL: String
  var milestonesURL: String
  var blobsURL: String
  var contributorsURL: String
  var openIssuesCount: Int
  var forksCount: Int
  var treesURL: String
  var svnURL: String
  var commitsURL: String
  var createdAt: String
  var forksURL: String
  var hasDownloads: Bool
  var mirrorURL: String?
  var homepage: String
  var teamsURL: String
  var branchesURL: String
  var issueCommentURL: String
  var mergesURL: String
  var gitRefsURL: String
  var gitURL: String
  var forks: Int
  var openIssues: Int
  var hooksURL: String
  var htmlURL: String
  var stargazersURL: String
  var assigneesURL: String
  var compareURL: String
  var fullName: String
  var tagsURL: String
  var releasesURL: String
  var pushedAt: String?
  var labelsURL: String
  var downloadsURL: String
  var stargazersCount: Int
  var watchersCount: Int
  var language: String
  var hasPages: Bool

  init(map: Map) {
    keysURL = (try? map.value("keys_url")) ?? ""
    statusesURL = (try? map.value("statuses_url")) ?? ""
    issuesURL = (try? map.value("issues_url")) ?? ""
    defaultBranch = (try? map.value("default_branch")) ?? ""
    issueEventsURL = (try? map.value("issues_events_url")) ?? ""
    id = try! map.value("id")
    owner = try! map.value("owner")
    eventsURL = (try? map.value("events_url")) ?? ""
    subscriptionURL = (try? map.value("subscription_url")) ?? ""
    watchers = (try? map.value("watchers")) ?? 0
    gitCommitsURL = (try? map.value("git_commits_url")) ?? ""
    subscribersURL = (try? map.value("subscribers_url")) ?? ""
    cloneURL = (try? map.value("clone_url")) ?? ""
    hasWiki = (try? map.value("has_wiki")) ?? false
    URL = (try? map.value("url")) ?? ""
    pullsURL = (try? map.value("pulls_url")) ?? ""
    fork = (try? map.value("fork")) ?? false
    notificationsURL = (try? map.value("notifications_url")) ?? ""
    description = (try? map.value("description")) ?? ""
    collaboratorsURL = (try? map.value("collaborators_url")) ?? ""
    deploymentsURL = (try? map.value("deployments_url")) ?? ""
    languagesURL = (try? map.value("languages_url")) ?? ""
    hasIssues = (try? map.value("has_issues")) ?? false
    commentsURL = (try? map.value("comments_url")) ?? ""
    isPrivate = (try? map.value("private")) ?? false
    size = (try? map.value("size")) ?? 0
    gitTagsURL = (try? map.value("git_tags_url")) ?? ""
    updatedAt = (try? map.value("updated_at")) ?? ""
    sshURL = (try? map.value("ssh_url")) ?? ""
    name = (try? map.value("name")) ?? ""
    contentsURL = (try? map.value("contents_url")) ?? ""
    archiveURL = (try? map.value("archive_url")) ?? ""
    milestonesURL = (try? map.value("milestones_url")) ?? ""
    blobsURL = (try? map.value("blobs_url")) ?? ""
    contributorsURL = (try? map.value("contributors_url")) ?? ""
    openIssuesCount = (try? map.value("open_issues_count")) ?? 0
    forksCount = (try? map.value("forks_count")) ?? 0
    treesURL = (try? map.value("trees_url")) ?? ""
    svnURL = (try? map.value("svn_url")) ?? ""
    commitsURL = (try? map.value("commits_url")) ?? ""
    createdAt = (try? map.value("created_at")) ?? ""
    forksURL = (try? map.value("forks_url")) ?? ""
    hasDownloads = (try? map.value("has_downloads")) ?? false
    mirrorURL = try? map.value("mirror_url")
    homepage = (try? map.value("homepage")) ?? ""
    teamsURL = (try? map.value("teams_url")) ?? ""
    branchesURL = (try? map.value("branches_url")) ?? ""
    issueCommentURL = (try? map.value("issue_comment_url")) ?? ""
    mergesURL = (try? map.value("merges_url")) ?? ""
    gitRefsURL = (try? map.value("git_refs_url")) ?? ""
    gitURL = (try? map.value("git_url")) ?? ""
    forks = (try? map.value("forks")) ?? 0
    openIssues = (try? map.value("open_issues")) ?? 0
    hooksURL = (try? map.value("hooks_url")) ?? ""
    htmlURL = (try? map.value("html_url")) ?? ""
    stargazersURL = (try? map.value("stargazers_url")) ?? ""
    assigneesURL = (try? map.value("assignees_url")) ?? ""
    compareURL = (try? map.value("compare_url")) ?? ""
    fullName = (try? map.value("full_name")) ?? ""
    tagsURL = (try? map.value("tags_url")) ?? ""
    releasesURL = (try? map.value("releases_url")) ?? ""
    pushedAt = (try? map.value("pushed_at"))
    labelsURL = (try? map.value("labels_url")) ?? ""
    downloadsURL = (try? map.value("downloads_url")) ?? ""
    stargazersCount = (try? map.value("stargazers_count")) ?? 0
    watchersCount = (try? map.value("watchers_count")) ?? 0
    language = (try? map.value("language")) ?? ""
    hasPages = (try? map.value("has_pages")) ?? false
  }
}
