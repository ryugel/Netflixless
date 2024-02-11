//
//  Youtube.swift
//  Netflixless
//
//  Created by Augustin Diabira on 03/02/2024.
//

import Foundation

struct YouTubeData: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: YouTubePageInfo?
    let items: [YouTubeItem]
}

struct YouTubeItem: Codable, Hashable {
    let kind, etag: String
    let id: YouTubeVideoID?
}

struct YouTubeVideoID: Codable, Hashable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct YouTubePageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
